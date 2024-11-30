import 'package:uuid/uuid.dart';

class ScheduleItem {
  final String id;
  String title;
  DateTime date;
  String? location;
  String? description;

  ScheduleItem({
    String? id,
    required this.title,
    required this.date,
    this.location,
    this.description,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'location': location,
      'description': description,
    };
  }

  factory ScheduleItem.fromMap(Map<String, dynamic> map) {
    return ScheduleItem(
      id: map['id'],
      title: map['title'],
      date: DateTime.parse(map['date']),
      location: map['location'],
      description: map['description'],
    );
  }
}
