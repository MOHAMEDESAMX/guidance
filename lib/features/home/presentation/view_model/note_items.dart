import 'package:uuid/uuid.dart';

class NoteItem {
  final String id;
  String content;
  DateTime date;

  NoteItem({
    String? id,
    required this.content,
    required this.date,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'date': date.toIso8601String(),
    };
  }

  factory NoteItem.fromMap(Map<String, dynamic> map) {
    return NoteItem(
      id: map['id'],
      content: map['content'],
      date: DateTime.parse(map['date']),
    );
  }
}
