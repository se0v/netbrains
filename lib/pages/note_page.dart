import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:netbrains/components/my_note_tile.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
        content: TextField(
          controller: _noteController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: const InputDecoration(
            hintText: "Введите заметку (ссылки определяются автоматически)",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              String noteText = _noteController.text;
              Navigator.pop(context);
              await databaseProvider.createNote(noteText);
              _showNoteWithLinks(noteText);
            },
            child: const Text("Сохранить"),
          ),
        ],
      ),
    );
  }

  /// Показывает диалог с обработанными ссылками
  void _showNoteWithLinks(String noteText) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Просмотр заметки"),
        content: SelectableText.rich(
          _parseTextWithLinks(noteText),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Закрыть"),
          ),
        ],
      ),
    );
  }

  /// Парсит текст, определяя ссылки и превращая их в кликабельные `TextSpan`
  TextSpan _parseTextWithLinks(String text) {
    final RegExp linkRegex = RegExp(
      r'(https?:\/\/[^\s]+)', // Регулярное выражение для поиска ссылок
      caseSensitive: false,
    );

    List<TextSpan> spans = [];
    int lastMatchEnd = 0;

    final matches = linkRegex.allMatches(text);
    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }

      final String url = match.group(0)!;
      spans.add(
        TextSpan(
          text: url,
          style: const TextStyle(
              color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()..onTap = () => _openUrl(url),
        ),
      );

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return TextSpan(
        style: const TextStyle(color: Colors.black), children: spans);
  }

  /// Открывает URL в браузере
  void _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print("Не удалось открыть ссылку: $url");
    }
  }
}
