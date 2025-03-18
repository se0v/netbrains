/*

NOTE TILE

------------------------------------------------------------------


*/

import 'package:flutter/material.dart';
import 'package:netbrains/components/my_progress_widget.dart';
import 'package:netbrains/services/database/database_provider.dart';
import 'package:netbrains/services/notification/notification_service.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class MyNoteTile extends StatefulWidget {
  final Note note;
  final void Function()? onNoteTap;
  final NotificationService notificationService;

  const MyNoteTile(
      {super.key,
      required this.note,
      required this.onNoteTap,
      required this.notificationService});

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

  // show options for note
  void _showOptions() {
    // show options
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
              child: Wrap(
            children: [
              // stat button
              ListTile(
                leading: const Icon(Icons.question_mark),
                title: const Text("Статистика повторений"),
                onTap: () async {
                  Navigator.pop(context);

                  // get steps from NotificationService
                  final notificationService = NotificationService();
                  int currentStep = await notificationService.getCurrentStep();
                  int totalSteps = notificationService.getTotalSteps();

                  // dialog with graph
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        "Статистика повторений",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MyProgressWidget(
                            currentStep: currentStep,
                            totalSteps: totalSteps,
                          ),
                          Text(
                            "\nСледующее повторение: через ${currentStep + 1} дня",
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "\nИнтервальные повторения помогают лучше запоминать информацию. Вместо заучивания за один раз, материал повторяется через увеличивающиеся промежутки времени.\n"
                            "Например:\n"
                            " - через 20 минут,\n"
                            " - через час,\n"
                            " - через 9 часов,\n"
                            " - на следующий день,\n"
                            " - через 2 дня,\n"
                            " - через 6 дней,\n"
                            " - через 2 недели,\n"
                            " - через месяц,\n"
                            " - через 2 месяца,\n"
                            " - через полгода.\n"
                            "Это снижает забывание и укрепляет знания в долгосрочной памяти.",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Закрыть"),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // remember button
              ListTile(
                leading: const Icon(Icons.extension),
                title: const Text("Запоминать!"),
                onTap: () async {
                  // closing dialog
                  Navigator.pop(context);
                  // sending noteText
                  await widget.notificationService
                      .showNotification(widget.note.note);
                },
              ),

              // delete note button
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text("Удалить"),
                onTap: () async {
                  // pop option box
                  Navigator.pop(context);

                  // handle delete action
                  await databaseProvider.deleteNote(widget.note.id);
                },
              ),

              // cancel button
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text("Отмена"),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ));
        });
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
            GestureDetector(
                onTap: _showOptions,
                child: Icon(
                  Icons.more_horiz,
                  color: Theme.of(context).colorScheme.primary,
                )),
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
