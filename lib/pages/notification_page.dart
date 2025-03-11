import 'package:flutter/material.dart';
import 'package:netbrains/models/note.dart';
import '../services/notification/notification_service.dart';

class NotificationPage extends StatelessWidget {
  final Note note;
  const NotificationPage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    DateTime? sendTime;
    final String? noteText =
        ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(title: const Text("Notification")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Пора повторить: \n\n$noteText',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                // time tracking
                sendTime = DateTime.now();
                print('Время отправки: $sendTime');
                await NotificationService().scheduleNotification(
                    id: 1,
                    title: 'Закрепи',
                    body: note.note,
                    noteText: note.note);
              },
              child: const Text("Повторил(-а)"),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  NotificationService().cancelNotification();
                },
                child: const Text("Прекратить повторения"))
          ],
        ),
      ),
    );
  }
}
