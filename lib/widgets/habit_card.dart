import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class HabitCard extends StatelessWidget {
  final String title;
  final String? description;
  final String frequency;
  final int points;
  final bool active;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

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
  }) : super(key: key);

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
                        title,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (description != null && description!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          description!,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    if (onEdit != null)
                      PopupMenuItem(
                        onTap: onEdit,
                        child: const Row(
                          children: [
                            Icon(Icons.edit, size: 20),
                            SizedBox(width: 8),
                            Text('Editar'),
                          ],
                        ),
                      ),
                    if (onDelete != null)
                      PopupMenuItem(
                        onTap: onDelete,
                        child: const Row(
                          children: [
                            Icon(Icons.delete, size: 20, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Deletar', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(_getFrequencyLabel(frequency)),
                  backgroundColor: AppTheme.primaryLight.withOpacity(0.2),
                  labelStyle: const TextStyle(color: AppTheme.primaryColor),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.accentColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: AppTheme.accentColor),
                      const SizedBox(width: 4),
                      Text(
                        '$points pts',
                        style: const TextStyle(
                          color: AppTheme.accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (!active)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
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
