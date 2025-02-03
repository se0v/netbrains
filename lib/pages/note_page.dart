import 'package:flutter/material.dart';
import 'package:netbrains/components/my_note_tile.dart';
import 'package:provider/provider.dart';

import '../components/my_drawer.dart';
import '../models/note.dart';
import '../services/database/database_provider.dart';
import '../services/notification/notification_service.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  // provider
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  // NotificationService
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _notificationService.initNotification();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    await databaseProvider.loadAllNotes();
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // SCAFFOLD
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: MyDrawer(),

      // App Bar
      appBar: AppBar(
        title: const Text("З А М Е Т К И"),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _openNoteDialog(),
        child: const Icon(Icons.add),
      ),
      body: _buildNoteList(listeningProvider.allNotes),
    );
  }

  Widget _buildNoteList(List<Note> notes) {
    return notes.isEmpty
        ? const Center(child: Text("Нет заметок"))
        : ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return MyNoteTile(
                note: note,
                onNoteTap: () {},
                notificationService: _notificationService,
              );
            },
          );
  }

  void _openNoteDialog() {
    TextEditingController _noteController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Добавить заметку"),
        content: TextField(controller: _noteController),
        actions: [
          TextButton(
            onPressed: () async {
              await databaseProvider.createNote(_noteController.text);
              Navigator.pop(context);
            },
            child: const Text("Сохранить"),
          ),
        ],
      ),
    );
  }
}
