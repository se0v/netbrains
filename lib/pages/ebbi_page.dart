import 'package:flutter/material.dart';
import 'package:netbrains/components/my_drawer.dart';
import 'package:netbrains/components/my_input_alert_box.dart';
import 'package:netbrains/helper/navigate_pages.dart';
import 'package:provider/provider.dart';

import '../components/my_note_tile.dart';
import '../services/database/database_provider.dart';
import '../services/notification/notification_service.dart';

import 'package:firebase_performance/firebase_performance.dart';

class EbbiPage extends StatefulWidget {
  final String uid;
  const EbbiPage({super.key, required this.uid});

  @override
  State<EbbiPage> createState() => _EbbiPageState();
}

class _EbbiPageState extends State<EbbiPage> {
  DateTime? sendTime;
  // Providers
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  // Text controllers
  final _noteController = TextEditingController();

  // Notification Service
  final NotificationService _notificationService = NotificationService();

  // On startup
  @override
  void initState() {
    super.initState();

    // Initialize notification service
    _notificationService.initNotification();

    // Load all the notes
    loadAllNotes();
  }

  // Load all notes with performance monitoring
  Future<void> loadAllNotes() async {
    final trace = FirebasePerformance.instance.newTrace("loadAllNotes_trace");
    trace.start();
    try {
      await databaseProvider.loadAllNotes();
    } finally {
      trace.stop();
    }
  }

  // Show create note dialog box
  void _openCreateNoteBox() {
    showDialog(
      context: context,
      builder: (context) => MyInputAlertBox(
        textController: _noteController,
        hintText: "Важная заметка",
        onPressed: () async {
          await createNote(_noteController.text);
          // time tracking
          sendTime = DateTime.now();
          print('Время создания записи $sendTime');
          // close dialog
          Navigator.pop(BuildContext as BuildContext);
        },
        onPressedText: "Ввод",
      ),
    );
  }

  // User wants to create note + performance monitoring
  Future<void> createNote(String note) async {
    final trace = FirebasePerformance.instance.newTrace("createNote_trace");
    trace.start();
    try {
      await databaseProvider.createNote(note);
      await loadAllNotes();
    } finally {
      trace.stop();
    }
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // Get user notes
    final allUserNotes = listeningProvider.filterUserNotes(widget.uid);

    // SCAFFOLD
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: MyDrawer(),

      // App Bar
      appBar: AppBar(
        title: const Text("З А М Е Т К И"),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),

      // Floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreateNoteBox,
        child: const Icon(Icons.add),
      ),

      // Body
      body: ListView(
        children: [
          allUserNotes.isEmpty
              ? const Center(child: Text("Ещё нет записей.."))
              : ListView.builder(
                  itemCount: allUserNotes.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // Get individual notes
                    final note = allUserNotes[index];

                    // Note tile UI
                    return MyNoteTile(
                      note: note,
                      onNoteTap: () => goNotePage(context, note),
                      notificationService: _notificationService,
                    );
                  },
                ),
        ],
      ),
    );
  }
}
