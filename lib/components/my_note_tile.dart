/*

NOTE TILE

------------------------------------------------------------------


*/

import 'package:flutter/material.dart';
import 'package:netbrains/services/database/database_provider.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class MyNoteTile extends StatefulWidget {
  final Note note;
  final void Function()? onNoteTap;

  const MyNoteTile({super.key, required this.note, required this.onNoteTap});

  @override
  State<MyNoteTile> createState() => _MyNoteTileState();
}

class _MyNoteTileState extends State<MyNoteTile> {
  // providers
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  // on startup
  @override
  void initState() {
    super.initState();

    // load all the notes
    loadAllNotes();
  }

  // load all notes
  Future<void> loadAllNotes() async {
    await databaseProvider.loadAllNotes();
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // Container
    return GestureDetector(
      onTap: widget.onNoteTap,
      child: Container(
        // Padding outside
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),

        // Padding inside
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          // Color of note tile
          color: Theme.of(context).colorScheme.secondary,
          // Curve corners
          borderRadius: BorderRadius.circular(8),
        ),
        // Column
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),

            // note
            SelectableText(
              widget.note.note,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
