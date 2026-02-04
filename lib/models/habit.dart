class Habit {
  final int? id;
  final int? userId;
  final String title;
  final String? description;
  final String frequency;
  final int? customFrequencyDays;
  final String? customFrequencyType;
  final int points;
  final bool active;
  final DateTime? createdAt;
  final bool? completed;

  Habit({
    this.id,
    this.userId,
    required this.title,
    this.description,
    required this.frequency,
    this.customFrequencyDays,
    this.customFrequencyType,
    required this.points,
    required this.active,
    this.createdAt,
    this.completed,
  });

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      frequency: json['frequency'],
      customFrequencyDays: json['custom_frequency_days'],
      customFrequencyType: json['custom_frequency_type'],
      points: json['points'],
      active: json['active'] ?? true,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'frequency': frequency,
      'custom_frequency_days': customFrequencyDays,
      'custom_frequency_type': customFrequencyType,
      'points': points,
      'active': active,
      'created_at': createdAt?.toIso8601String(),
      'completed': completed,
    };
  }

  Habit copyWith({
    int? id,
    int? userId,
    String? title,
    String? description,
    String? frequency,
    int? customFrequencyDays,
    String? customFrequencyType,
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
      customFrequencyDays: customFrequencyDays ?? this.customFrequencyDays,
      customFrequencyType: customFrequencyType ?? this.customFrequencyType,
      points: points ?? this.points,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      completed: completed ?? this.completed,
    );
  }
}
