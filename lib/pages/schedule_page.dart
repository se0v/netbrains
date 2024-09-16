import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:netbrains/services/auth/auth_service.dart';
import 'package:table_calendar/table_calendar.dart';

import '../components/my_drawer.dart';
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
  String? uid;

  @override
  void initState() {
    super.initState();
    _selectedDate = _focusedDay;

    // get current uid
    uid = AuthService().getCurrentUid();

    if (uid != null) {
      loadMonthEvents(_focusedDay);
    }
  }

  Future<void> _deleteEvent(String eventId) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);

    // Вызов метода удаления события
    await databaseService.deleteEvent(formattedDate, eventId);

    // Обновление состояния
    setState(() {
      mySelectedEvents[formattedDate] = mySelectedEvents[formattedDate]
              ?.where((event) => event['id'] != eventId)
              .toList() ??
          [];
    });
  }

  // Загрузка предыдущих событий из Firestore
  loadMonthEvents(DateTime focusedDay) async {
    if (uid == null) return;
    final firstDayOfMonth = DateTime(focusedDay.year, focusedDay.month, 1);
    final lastDayOfMonth = DateTime(focusedDay.year, focusedDay.month + 1, 0);

    for (var day = firstDayOfMonth;
        day.isBefore(lastDayOfMonth.add(const Duration(days: 1)));
        day = day.add(const Duration(days: 1))) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(day);
      List<Map<String, dynamic>> events =
          await databaseService.getEvents(formattedDate, uid!);

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

                // Получение uid текущего пользователя
                String? uid = AuthService().getCurrentUid();

                await databaseService.saveEvent(formattedDate, newEvent, uid);

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
      drawer: MyDrawer(),
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
            calendarStyle: CalendarStyle(
              // Цвет выделенного дня
              selectedDecoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .onTertiary, // Цвет фона выбранного дня
                shape: BoxShape.circle,
              ),
              // Цвет кружочка для сегодняшней даты
              todayDecoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primary, // Цвет кружочка для сегодняшней даты
                shape: BoxShape.circle,
              ),
              // Настройка цвета индикаторов событий (кружочки под датами)
              markerDecoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .outline, // Цвет индикаторов событий
                shape: BoxShape.circle,
              ),
              markersMaxCount: 3, // Ограничение на количество индикаторов
              markerSize: 6.0, // Размер индикаторов событий
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _listOfDayEvents(_selectedDate!).length,
              itemBuilder: (context, index) {
                final myEvent = _listOfDayEvents(_selectedDate!)[index];
                final eventId = myEvent['id']; // Идентификатор события

                return ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      // Показать модальное окно с опциями
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SafeArea(
                            child: Wrap(
                              children: <Widget>[
                                ListTile(
                                  leading: const Icon(Icons.delete),
                                  title: const Text('Удалить'),
                                  onTap: () async {
                                    // Удаление события
                                    await _deleteEvent(eventId);
                                    Navigator.pop(
                                        context); // Закрыть модальное окно
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.cancel),
                                  title: const Text('Отмена'),
                                  onTap: () {
                                    // Здесь можно добавить логику редактирования события
                                    Navigator.pop(
                                        context); // Закрыть модальное окно
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  contentPadding: const EdgeInsets.only(left: 4, right: 8),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
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
