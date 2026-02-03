class Habit {
  final int? id;
  final int? userId;
  final String title;
  final String? description;
  final String frequency;
  final int points;
  final bool active;
  final DateTime? createdAt;

  Habit({
    this.id,
    this.userId,
    required this.title,
    this.description,
    required this.frequency,
    required this.points,
    required this.active,
    this.createdAt,
  });

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      frequency: json['frequency'],
      points: json['points'],
      active: json['active'] ?? true,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'frequency': frequency,
      'points': points,
      'active': active,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  Habit copyWith({
    int? id,
    int? userId,
    String? title,
    String? description,
    String? frequency,
    int? points,
    bool? active,
    DateTime? createdAt,
  }) {
    return Habit(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      frequency: frequency ?? this.frequency,
      points: points ?? this.points,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
