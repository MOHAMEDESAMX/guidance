import 'package:flutter/material.dart';
import 'package:guidance/core/functions/pdf_generator.dart';
import 'package:guidance/features/home/presentation/view_model/schedule_items.dart';
import 'package:guidance/features/home/presentation/views/widgets/schedule_item_card.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<ScheduleItem> scheduleItems = [];
  final DateFormat dateFormatter = DateFormat('yyyy/MM/dd');
  final TimeOfDay initialTime = TimeOfDay.now();

  Future<void> _addScheduleItem() async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController locationController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add New Schedule Item'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: locationController,
                      decoration: const InputDecoration(
                        labelText: 'Location',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      title:
                          Text('Date: ${dateFormatter.format(selectedDate)}'),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                    ),
                    ListTile(
                      title: Text('Time: ${selectedTime.format(context)}'),
                      trailing: const Icon(Icons.access_time),
                      onTap: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );
                        if (picked != null) {
                          setState(() {
                            selectedTime = picked;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      final DateTime dateTime = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute,
                      );

                      setState(() {
                        scheduleItems.add(ScheduleItem(
                          title: titleController.text,
                          date: dateTime,
                          location: locationController.text,
                        ));
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deleteScheduleItem(String id) {
    setState(() {
      scheduleItems.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Sort items by date
    scheduleItems.sort((a, b) => a.date.compareTo(b.date));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () => PdfGenerator.generatePdf(context, scheduleItems),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: scheduleItems.length,
        itemBuilder: (context, index) {
          return ScheduleItemCard(
            scheduleItem: scheduleItems[index],
            onDelete: _deleteScheduleItem,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addScheduleItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}
