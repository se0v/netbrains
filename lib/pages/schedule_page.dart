import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../services/database/database_service.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  Map<String, List<Map<String, dynamic>>> mySelectedEvents = {};

  final titleController = TextEditingController();
  final descpController = TextEditingController();
  final databaseService =
      DatabaseService(); // Инициализация сервиса базы данных

  @override
  void initState() {
    super.initState();
    _selectedDate = _focusedDay;
    loadMonthEvents(_focusedDay);
  }

  // Загрузка предыдущих событий из Firestore
  loadMonthEvents(DateTime focusedDay) async {
    final firstDayOfMonth = DateTime(focusedDay.year, focusedDay.month, 1);
    final lastDayOfMonth = DateTime(focusedDay.year, focusedDay.month + 1, 0);

    for (var day = firstDayOfMonth;
        day.isBefore(lastDayOfMonth.add(const Duration(days: 1)));
        day = day.add(const Duration(days: 1))) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(day);
      List<Map<String, dynamic>> events =
          await databaseService.getEvents(formattedDate);

      if (mounted) {
        // Обновляем состояние только если виджет все еще смонтирован
        setState(() {
          mySelectedEvents[formattedDate] = events;
        });
      }
    }
  }

  // Сохранение нового события в Firestore
  _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Написать комментарий',
          textAlign: TextAlign.center,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                hintText: "Заголовок",
              ),
            ),
            TextField(
              controller: descpController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                hintText: "Текст",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            child: const Text('Ввод'),
            onPressed: () async {
              if (titleController.text.isEmpty &&
                  descpController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Поля не заполнены'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              } else {
                final newEvent = {
                  "eventTitle": titleController.text,
                  "eventDescp": descpController.text,
                };

                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(_selectedDate!);

                // Сохранение события в Firestore
                await databaseService.saveEvent(formattedDate, newEvent);

                // Обновление состояния
                setState(() {
                  if (mySelectedEvents[formattedDate] != null) {
                    mySelectedEvents[formattedDate]!.add(newEvent);
                  } else {
                    mySelectedEvents[formattedDate] = [newEvent];
                  }
                });

                titleController.clear();
                descpController.clear();
                Navigator.pop(context);
                return;
              }
            },
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _listOfDayEvents(DateTime dateTime) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return mySelectedEvents[formattedDate] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Р А С П И С А Н И Е"),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'ru_RU',
            focusedDay: _focusedDay,
            firstDay: DateTime(2023),
            lastDay: DateTime(2025),
            calendarFormat: _calendarFormat,
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDate, selectedDay)) {
                setState(() {
                  _selectedDate = selectedDay;
                  _focusedDay = focusedDay;
                  loadMonthEvents(
                      focusedDay); // Перезагрузите события при смене даты
                });
              }
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
              loadMonthEvents(focusedDay);
            },
            eventLoader: (date) {
              String formattedDate = DateFormat('yyyy-MM-dd').format(date);
              return mySelectedEvents[formattedDate] ?? [];
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _listOfDayEvents(_selectedDate!).length,
              itemBuilder: (context, index) {
                final myEvent = _listOfDayEvents(_selectedDate!)[index];
                return ListTile(
                  leading: const Icon(
                    Icons.done,
                    color: Colors.teal,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      '${myEvent['eventTitle']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Text('${myEvent['eventDescp']}'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(),
        label: const Text('Комментировать'),
      ),
    );
  }
}
