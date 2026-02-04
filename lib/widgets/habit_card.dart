import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class HabitCard extends StatefulWidget {
  final String title;
  final String? description;
  final String frequency;
  final int points;
  final bool active;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool? completed;
  final ValueChanged<bool?>? onCompletedChanged;

  const HabitCard({
    Key? key,
    required this.title,
    this.description,
    required this.frequency,
    required this.points,
    required this.active,
    required this.onTap,
    this.onEdit,
    this.onDelete,
    this.completed,
    this.onCompletedChanged,
  }) : super(key: key);

  @override
  _HabitCardState createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    isCompleted = widget.completed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (widget.description != null &&
                          widget.description!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          widget.description!,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                if (widget.onCompletedChanged != null)
                  Checkbox(
                    value: isCompleted,
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                      (states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.green;
                        }
                        return Colors.grey;
                      },
                    ),
                    onChanged: (value) async {
                      setState(() {
                        isCompleted = value ?? false;
                      });

                      if (widget.onCompletedChanged != null) {
                        widget.onCompletedChanged!(value);
                      }
                    },
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(_getFrequencyLabel(widget.frequency)),
                  backgroundColor: AppTheme.primaryLight.withOpacity(0.2),
                  labelStyle:
                      const TextStyle(color: AppTheme.primaryColor),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color:
                            AppTheme.accentColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: AppTheme.accentColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.points} pts',
                            style: const TextStyle(
                              color: AppTheme.accentColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.onEdit != null ||
                        widget.onDelete != null)
                      PopupMenuButton<int>(
                        itemBuilder: (context) {
                          final items =
                              <PopupMenuEntry<int>>[];
                          if (widget.onEdit != null) {
                            items.add(
                              PopupMenuItem<int>(
                                value: 0,
                                child: Row(
                                  children: [
                                    const Icon(Icons.edit,
                                        size: 20),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: widget.onEdit,
                                      child:
                                          const Text('Editar'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          if (widget.onDelete != null) {
                            items.add(
                              PopupMenuItem<int>(
                                value: 1,
                                child: Row(
                                  children: [
                                    const Icon(Icons.delete,
                                        size: 20,
                                        color: Colors.red),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: widget.onDelete,
                                      child: const Text(
                                        'Deletar',
                                        style: TextStyle(
                                            color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return items;
                        },
                      ),
                  ],
                ),
              ],
            ),
            if (!widget.active)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius:
                        BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Inativo',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getFrequencyLabel(String frequency) {
    switch (frequency.toLowerCase()) {
      case 'daily':
        return 'Diário';
      case 'weekly':
        return 'Semanal';
      case 'monthly':
        return 'Mensal';
      case 'yearly':
        return 'Anual';
      default:
        return frequency;
    }
  }
}
