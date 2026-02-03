import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/stats_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final authProvider = context.read<AuthProvider>();
    final statsProvider = context.read<StatsProvider>();

    if (authProvider.token != null) {
      statsProvider.loadStats(authProvider.token!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estatísticas'),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Consumer2<AuthProvider, StatsProvider>(
        builder: (context, authProvider, statsProvider, child) {
          if (statsProvider.isLoading) {
            return LoadingWidget(message: 'Carregando estatísticas...');
          }

          if (statsProvider.stats == null) {
            return EmptyStateWidget(
              title: 'Sem dados',
              message: 'Crie e complete hábitos para ver suas estatísticas',
              icon: Icons.bar_chart_outlined,
            );
          }

          final stats = statsProvider.stats!;
          return RefreshIndicator(
            onRefresh: () => _loadStats(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Resumo Principal
                    Container(
                      padding: const EdgeInsets.all(24),
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
                            'Resumo Geral',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _StatItem(
                                icon: Icons.star,
                                label: 'Pontos',
                                value: '${stats.totalPoints}',
                                color: Colors.white,
                              ),
                              _StatItem(
                                icon: Icons.trending_up,
                                label: 'Nível',
                                value: '${stats.level}',
                                color: Colors.white,
                              ),
                              _StatItem(
                                icon: Icons.local_fire_department,
                                label: 'Streak',
                                value: '${stats.streak} dias',
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Detalhes
                    Text(
                      'Detalhes',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    _DetailCard(
                      icon: Icons.star,
                      title: 'Total de Pontos',
                      value: '${stats.totalPoints}',
                      subtitle: 'Pontos acumulados',
                      color: AppTheme.accentColor,
                    ),
                    const SizedBox(height: 12),
                    _DetailCard(
                      icon: Icons.trending_up,
                      title: 'Nível Atual',
                      value: '${stats.level}',
                      subtitle: 'Sua progressão',
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 12),
                    _DetailCard(
                      icon: Icons.local_fire_department,
                      title: 'Maior Sequência',
                      value: '${stats.streak}',
                      subtitle: 'Dias em sequência',
                      color: Colors.red,
                    ),
                    const SizedBox(height: 32),

                    // Dicas
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info, color: Colors.blue[700]),
                              const SizedBox(width: 12),
                              Text(
                                'Dica',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[700],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Complete seus hábitos diariamente para manter sua sequência e ganhar mais pontos!',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _DetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final Color color;

  const _DetailCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
