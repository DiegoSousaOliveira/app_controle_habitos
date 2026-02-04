import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/habit_provider.dart';
import '../../providers/stats_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/habit_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final authProvider = context.read<AuthProvider>();
    final habitProvider = context.read<HabitProvider>();
    final statsProvider = context.read<StatsProvider>();

    if (authProvider.token != null) {
      habitProvider.loadHabits(authProvider.token!);
      statsProvider.loadStats(authProvider.token!);
    }
  }

  Future<void> _onRefresh() async {
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle de Hábitos'),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: _buildHomeView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/habits/create'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _selectedNavIndex,
        onTap: (index) {
          setState(() {
            _selectedNavIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildHomeView() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.primaryColor, AppTheme.primaryDark],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bem-vindo, ${authProvider.user?.name}!',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Continue acompanhando seus hábitos',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              // ...removido barra de progresso...
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Seus Hábitos',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () => context.go('/habits'),
                    child: const Text('Ver Tudo'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Consumer<HabitProvider>(
                builder: (context, habitProvider, child) {
                  if (habitProvider.isLoading) {
                    return LoadingWidget();
                  }

                  if (habitProvider.habits.isEmpty) {
                    return EmptyStateWidget(
                      title: 'Nenhum hábito criado',
                      message: 'Comece criando seu primeiro hábito',
                      icon: Icons.add_circle_outline,
                      onAction: () => context.go('/habits/create'),
                      actionLabel: 'Criar Hábito',
                    );
                  }

                  // Show only first 3 habits
                  final displayHabits = habitProvider.habits.take(3).toList();
                  final authProvider = context.read<AuthProvider>();
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: displayHabits.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final habit = displayHabits[index];
                      return HabitCard(
                        title: habit.title,
                        description: habit.description,
                        frequency: habit.frequency,
                        points: habit.points,
                        active: habit.active,
                        onTap: () {},
                        completed: habit.completed ?? false,
                        onCompletedChanged: (checked) async {
                          await context.read<HabitProvider>().logHabitCompletion(
                            token: authProvider.token!,
                            habitId: habit.id!,
                            completed: checked ?? false,
                          );
                          // Atualizar estatísticas após marcar/desmarcar como concluído
                          await context.read<StatsProvider>().loadStats(authProvider.token!);
                        },
                      );
                    },
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

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
