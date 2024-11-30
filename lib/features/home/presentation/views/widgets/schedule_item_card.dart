import 'package:flutter/material.dart';
import 'package:guidance/core/functions/data_formting.dart';
import 'package:guidance/features/home/presentation/view_model/schedule_items.dart';

class ScheduleItemCard extends StatelessWidget {
  final ScheduleItem scheduleItem;
  final Function(String) onDelete;

  const ScheduleItemCard({
    super.key,
    required this.scheduleItem,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final TimeOfDay time = TimeOfDay.fromDateTime(scheduleItem.date);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(
          scheduleItem.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '${DateFormatter.formatDate(scheduleItem.date)} - ${time.format(context)}'),
            if (scheduleItem.location != null &&
                scheduleItem.location!.isNotEmpty)
              Text('Location: ${scheduleItem.location}'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => onDelete(scheduleItem.id),
        ),
      ),
    );
  }
}
