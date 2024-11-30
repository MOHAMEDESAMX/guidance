import 'package:flutter/material.dart';
import 'package:guidance/features/home/presentation/view_model/note_items.dart';

class NoteListItem extends StatelessWidget {
  final NoteItem note;
  final Function(NoteItem) onEdit;
  final Function(String) onDelete;

  const NoteListItem({
    super.key,
    required this.note,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(note.content),
        subtitle: Text(note.date.toString().split(' ')[0]),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => onEdit(note),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => onDelete(note.id),
            ),
          ],
        ),
      ),
    );
  }
}
