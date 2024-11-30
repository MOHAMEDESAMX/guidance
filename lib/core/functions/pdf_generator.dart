import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guidance/features/home/presentation/view_model/schedule_items.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfGenerator {
  static Future<void> generatePdf(
      BuildContext context, List<ScheduleItem> items) async {
    final pdf = pw.Document();
    final DateFormat dateFormatter = DateFormat('yyyy/MM/dd HH:mm');

    items.sort((a, b) => a.date.compareTo(b.date));

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text('Schedule',
                    style: const pw.TextStyle(fontSize: 24)),
              ),
              pw.SizedBox(height: 20),
              ...items.map((item) => pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        item.title,
                        style: pw.TextStyle(
                            fontSize: 14, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        dateFormatter.format(item.date),
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                      if (item.location != null && item.location!.isNotEmpty)
                        pw.Text(
                          'Location: ${item.location}',
                          style: const pw.TextStyle(fontSize: 12),
                        ),
                      pw.Divider(),
                    ],
                  )),
            ],
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/schedule.pdf');
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PDF saved to ${file.path}')),
    );
  }
}
