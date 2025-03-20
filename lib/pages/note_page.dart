import 'package:flutter/material.dart';
import '../models/note.dart';
import '../components/my_note_content.dart';

class NotePage extends StatelessWidget {
  final Note note;

  const NotePage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Просмотр заметки"),
      ),
      body: MyNoteContent(
        text: note.note,
        isCentered: true,
      ),
    );
  }
}
