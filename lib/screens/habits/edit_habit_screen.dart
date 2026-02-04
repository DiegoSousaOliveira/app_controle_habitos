import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../models/habit.dart';
import '../../providers/auth_provider.dart';
import '../../providers/habit_provider.dart';
import '../../theme/app_theme.dart';
import '../../utils/api_exceptions.dart';
import '../../widgets/common_widgets.dart';

class EditHabitScreen extends StatefulWidget {
  final Habit habit;

  const EditHabitScreen({
    Key? key,
    required this.habit,
  }) : super(key: key);

  @override
  State<EditHabitScreen> createState() => _EditHabitScreenState();
}

class _EditHabitScreenState extends State<EditHabitScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _pointsController;
  late TextEditingController _customFrequencyDaysController;
  final _formKey = GlobalKey<FormState>();

  late String _selectedFrequency;
  late String _customFrequencyType;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.habit.title);
    _descriptionController =
        TextEditingController(text: widget.habit.description ?? '');
    _pointsController =
        TextEditingController(text: widget.habit.points.toString());
    _customFrequencyDaysController = TextEditingController(
      text: widget.habit.customFrequencyDays?.toString() ?? '',
    );
    _selectedFrequency = widget.habit.frequency;
    _customFrequencyType = widget.habit.customFrequencyType ?? 'days';
    _isActive = widget.habit.active;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _pointsController.dispose();
    _customFrequencyDaysController.dispose();
    super.dispose();
  }

  Future<void> _handleUpdateHabit() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();
    final habitProvider = context.read<HabitProvider>();

    if (authProvider.token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro: Usuário não autenticado')),
      );
      return;
    }

    try {
      int? customDays;
      String? customType;

      if (_selectedFrequency == 'custom') {
        customDays = int.tryParse(_customFrequencyDaysController.text);
        customType = _customFrequencyType;
      }

      await habitProvider.updateHabit(
        token: authProvider.token!,
        habitId: widget.habit.id!,
        title: _titleController.text.trim(),
        description: _descriptionController.text.isEmpty
            ? null
            : _descriptionController.text.trim(),
        frequency: _selectedFrequency,
        points: int.parse(_pointsController.text),
        active: _isActive,
        customFrequencyDays: customDays,
        customFrequencyType: customType,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hábito atualizado com sucesso')),
      );
      context.go('/habits');
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: ${e.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Hábito'),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Título
              Text(
                'Informações Básicas',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Título do Hábito*',
                  hintText: 'Ex: Beber 2L de água',
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Título é obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  hintText: 'Descreva seu hábito em detalhes',
                  prefixIcon: Icon(Icons.description),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 24),

              // Frequência
              Text(
                'Configurações',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                value: _selectedFrequency,
                decoration: const InputDecoration(
                  labelText: 'Frequência*',
                  prefixIcon: Icon(Icons.schedule),
                ),
                items: const [
                  DropdownMenuItem(value: 'daily', child: Text('Diário')),
                  DropdownMenuItem(value: 'weekly', child: Text('Semanal')),
                  DropdownMenuItem(value: 'monthly', child: Text('Mensal')),
                  DropdownMenuItem(value: 'yearly', child: Text('Anual')),
                  DropdownMenuItem(value: 'custom', child: Text('Personalizado')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedFrequency = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              if (_selectedFrequency == 'custom') ...[
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _customFrequencyDaysController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Intervalo*',
                          hintText: 'Ex: 3',
                          prefixIcon: Icon(Icons.numbers),
                        ),
                        validator: (value) {
                          if (_selectedFrequency == 'custom') {
                            if (value?.isEmpty ?? true) {
                              return 'Campo obrigatório';
                            }
                            final days = int.tryParse(value!);
                            if (days == null || days < 1) {
                              return 'Valor inválido';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: DropdownButtonFormField(
                        value: _customFrequencyType,
                        decoration: const InputDecoration(
                          labelText: 'Unidade*',
                        ),
                        items: const [
                          DropdownMenuItem(value: 'days', child: Text('Dias')),
                          DropdownMenuItem(value: 'weeks', child: Text('Semanas')),
                          DropdownMenuItem(value: 'months', child: Text('Meses')),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _customFrequencyType = value;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: _pointsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Pontos*',
                  hintText: '10',
                  prefixIcon: Icon(Icons.star),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Pontos é obrigatório';
                  }
                  final points = int.tryParse(value!);
                  if (points == null || points < 1 || points > 1000) {
                    return 'Pontos deve estar entre 1 e 1000';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Status
              Text(
                'Status',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.dividerColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Hábito Ativo'),
                    Switch(
                      value: _isActive,
                      onChanged: (value) {
                        setState(() {
                          _isActive = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Botões
              Consumer<HabitProvider>(
                builder: (context, habitProvider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: habitProvider.isLoading ? null : _handleUpdateHabit,
                        child: habitProvider.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text('Atualizar Hábito'),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton(
                        onPressed: () => context.go('/habits'),
                        child: const Text('Cancelar'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
