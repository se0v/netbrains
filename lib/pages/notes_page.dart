import 'package:flutter/material.dart';
import 'package:netbrains/components/my_note_tile.dart';
import 'package:netbrains/pages/note_page.dart';
import 'package:provider/provider.dart';

import '../components/my_drawer.dart';
import '../models/note.dart';
import '../services/database/database_provider.dart';
import '../services/notification/notification_service.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key, required String uid});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: MyDrawer(),
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
                onNoteTap: () {
                  // open NotePage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotePage(note: note),
                    ),
                  );
                },
                notificationService: _notificationService,
              );
            },
          );
  }

  void _openNoteDialog() {
    TextEditingController noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Добавить заметку"),
        content: TextField(
          controller: noteController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: const InputDecoration(
            hintText:
                "Введите текст заметки (URL изображения можно добавить в тексте)",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              String noteText = noteController.text.trim();
              await databaseProvider.createNote(noteText);
              Navigator.pop(context);
            },
            child: const Text("Сохранить"),
          ),
        ],
      ),
    );
  }
}
