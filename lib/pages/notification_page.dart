import 'package:flutter/material.dart';
import 'package:netbrains/models/note.dart';

class NotificationPage extends StatelessWidget {
  final Note note;
  const NotificationPage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final String? noteId =
        ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(title: const Text("Notification")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Заметка ID: $noteId',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Повторил(-а)"),
            ),
          ],
        ),
      ),
    );
  }
}
