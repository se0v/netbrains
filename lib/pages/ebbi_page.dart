import 'package:flutter/material.dart';
import 'package:netbrains/components/my_drawer.dart';
import 'package:netbrains/components/my_input_alert_box.dart';
import 'package:netbrains/helper/navigate_pages.dart';
import 'package:provider/provider.dart';

import '../components/my_note_tile.dart';
import '../services/database/database_provider.dart';

class EbbiPage extends StatefulWidget {
  final String uid;
  const EbbiPage({super.key, required this.uid});

  @override
  State<EbbiPage> createState() => _EbbiPageState();
}

class _EbbiPageState extends State<EbbiPage> {
  //providers
  late final listeningProvider = Provider.of<DatabaseProvider>(context);
  late final databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  // text controllers
  final _noteController = TextEditingController();

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

  // show create note dialog box
  void _openCreateNoteBox() {
    showDialog(
      context: context,
      builder: (context) => MyInputAlertBox(
          textController: _noteController,
          hintText: "Важная заметка",
          onPressed: () async {
            // note in db
            await createNote(_noteController.text);
          },
          onPressedText: "Ввод"),
    );
  }

  // user wants to create note
  Future<void> createNote(String note) async {
    await databaseProvider.createNote(note);
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // get user notes
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

        // Floatting action button
        floatingActionButton: FloatingActionButton(
          onPressed: _openCreateNoteBox,
          child: const Icon(Icons.add),
        ),

        // Body
        body: ListView(children: [
          allUserNotes.isEmpty
              ?

              // user note is empty
              const Center(
                  child: Text("Ещё нет записей.."),
                )
              :
              // user note is NOT empty
              ListView.builder(
                  itemCount: allUserNotes.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // get individual notes
                    final note = allUserNotes[index];

                    // note tile UI
                    return MyNoteTile(
                        note: note, onNoteTap: () => goNotePage(context, note));
                  },
                )
        ]));
  }
}
