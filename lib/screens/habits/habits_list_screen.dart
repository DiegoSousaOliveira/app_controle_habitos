import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/habit_provider.dart';
import '../../theme/app_theme.dart';
import '../../utils/api_exceptions.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/habit_card.dart';

class HabitsListScreen extends StatefulWidget {
  const HabitsListScreen({Key? key}) : super(key: key);

  @override
  State<HabitsListScreen> createState() => _HabitsListScreenState();
}

class _HabitsListScreenState extends State<HabitsListScreen> {
  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    final authProvider = context.read<AuthProvider>();
    final habitProvider = context.read<HabitProvider>();

    if (authProvider.token != null) {
      habitProvider.loadHabits(authProvider.token!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Hábitos'),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Consumer2<AuthProvider, HabitProvider>(
        builder: (context, authProvider, habitProvider, child) {
          if (habitProvider.isLoading) {
            return LoadingWidget(message: 'Carregando hábitos...');
          }

          if (habitProvider.habits.isEmpty) {
            return EmptyStateWidget(
              title: 'Nenhum hábito criado',
              message: 'Comece criando seu primeiro hábito para acompanhar',
              icon: Icons.add_circle_outline,
              onAction: () => context.go('/habits/create'),
              actionLabel: 'Criar Hábito',
            );
          }

          return RefreshIndicator(
            onRefresh: () => _loadHabits(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: habitProvider.habits.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final habit = habitProvider.habits[index];
                return HabitCard(
                  title: habit.title,
                  description: habit.description,
                  frequency: habit.frequency,
                  points: habit.points,
                  active: habit.active,
                  onTap: () {
                    // TODO: Navigate to habit details
                  },
                  onEdit: () {
                    // TODO: Navigate to edit habit
                  },
                  onDelete: () {
                    _showDeleteConfirmation(
                      context,
                      habit.id!,
                      habit.title,
                      authProvider.token!,
                      habitProvider,
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/habits/create'),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    int habitId,
    String habitTitle,
    String token,
    HabitProvider habitProvider,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deletar Hábito'),
        content: Text('Tem certeza que deseja deletar "$habitTitle"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await habitProvider.deleteHabit(
                  token: token,
                  habitId: habitId,
                );
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Hábito deletado com sucesso')),
                );
              } on ApiException catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Erro: ${e.message}')),
                );
              }
            },
            child: const Text(
              'Deletar',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
