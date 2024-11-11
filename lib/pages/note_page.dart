import 'package:flutter/material.dart';
import 'package:netbrains/components/my_note_tile.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../services/database/database_provider.dart';

class NotePage extends StatefulWidget {
  final Note note;

  const NotePage({super.key, required this.note});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  // provider
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // SCAFFOLD
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,

        // App Bar
        appBar: AppBar(
          foregroundColor: Theme.of(context).colorScheme.primary,
        ),

        // Body
        body: ListView(
          children: [
            // Note
            MyNoteTile(note: widget.note, onNoteTap: () {}),
          ],
        ));
  }
}
