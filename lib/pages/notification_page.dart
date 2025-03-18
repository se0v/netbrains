import 'package:flutter/material.dart';
import '../components/my_progress_widget.dart';
import '../components/my_note_content.dart';
import '../models/note.dart';
import '../services/notification/notification_service.dart';

class NotificationPage extends StatefulWidget {
  final Note note;

  const NotificationPage({super.key, required this.note});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int currentStep = 0;
  int totalSteps = 0;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final notificationService = NotificationService();
    int step = await notificationService.getCurrentStep();
    int total = notificationService.getTotalSteps();
    setState(() {
      currentStep = step;
      totalSteps = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Повторение")),
      body: Column(
        children: [
          Expanded(
              child: MyNoteContent(text: widget.note.note, isCentered: true)),

          // progress
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                MyProgressWidget(
                  currentStep: currentStep,
                  totalSteps: totalSteps,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    await NotificationService().scheduleNotification(
                      id: 1,
                      title: 'Закрепи',
                      body: widget.note.note,
                      noteText: widget.note.note,
                    );
                    _loadProgress();
                  },
                  child: Text("Повторить через ${currentStep + 1} дней"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    NotificationService().cancelNotification();
                  },
                  child: const Text("Прекратить повторения"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
