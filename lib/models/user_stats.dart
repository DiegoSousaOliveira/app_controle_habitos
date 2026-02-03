class UserStats {
  final int? id;
  final int? userId;
  final int totalPoints;
  final int level;
  final int streak;

  UserStats({
    this.id,
    this.userId,
    required this.totalPoints,
    required this.level,
    required this.streak,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      id: json['id'],
      userId: json['user_id'],
      totalPoints: json['total_points'] ?? 0,
      level: json['level'] ?? 1,
      streak: json['streak'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'total_points': totalPoints,
      'level': level,
      'streak': streak,
    };
  }

  UserStats copyWith({
    int? id,
    int? userId,
    int? totalPoints,
    int? level,
    int? streak,
  }) {
    return UserStats(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      totalPoints: totalPoints ?? this.totalPoints,
      level: level ?? this.level,
      streak: streak ?? this.streak,
    );
  }
}
