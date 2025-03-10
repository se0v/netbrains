import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import '../../main.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  Future<void> initNotification() async {
    if (_isInitialized) return;

    try {
      tz.initializeTimeZones();
      // Android initialization settings
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@drawable/ic_launcher');

      // iOS initialization settings
      const DarwinInitializationSettings initializationSettingsDarwin =
          DarwinInitializationSettings();

      // General initialization settings
      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
      );

      // Initialize the plugin
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          if (response.payload != null) {
            navigatorKey.currentState?.popUntil((route) => route.isFirst);
            navigatorKey.currentState?.pushNamed(
              '/notification_screen',
              arguments: response.payload,
            );
          }
        },
      );

      _isInitialized = true;
    } catch (e) {
      print("Error initializing notification service: $e");
    }
  }

  Future<void> showNotification(String noteText) async {
    if (!_isInitialized) {
      await initNotification();
    }

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id',
      'Channel Name',
      channelDescription: 'Channel Description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Запомни',
      'А то забудешь',
      notificationDetails,
      payload: noteText,
    );
  }

  Future<void> scheduleNotification({
    int id = 1,
    required String title,
    required String body,
    required String noteText,
  }) async {
    if (!_isInitialized) {
      await initNotification();
    }

    final now = tz.TZDateTime.now(tz.local);

    // ✅ Список задержек по Эббингаузу (0 → 3 → 5 → 7 секунд)
    final List<int> delays = [1, 10, 15];

    // ✅ Получаем текущий шаг из SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentStep = prefs.getInt('ebbinghaus_step') ?? 0;

    // ✅ Если шаги закончились, сбрасываем на 0
    if (currentStep >= delays.length) {
      currentStep = 0;
    }

    final int delay = delays[currentStep]; // Берём текущую задержку
    final scheduledDate = now.add(Duration(seconds: delay));

    // ✅ Проверяем, чтобы дата была в будущем
    final safeScheduledDate = scheduledDate.isBefore(now)
        ? now.add(const Duration(seconds: 1))
        : scheduledDate;

    final notificationId =
        id + currentStep; // ✅ Уникальный ID для каждого уведомления

    print(
        "📆 Шаг ${currentStep + 1}: Уведомление запланировано через $delay секунд на $safeScheduledDate");

    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      title,
      "$body (шаг ${currentStep + 1})",
      safeScheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'delayed_channel_id',
          'Delayed Notifications',
          channelDescription: 'Уведомления по методу Эббингауза',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: noteText,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );

    // ✅ Увеличиваем шаг для следующего вызова
    await prefs.setInt('ebbinghaus_step', currentStep + 1);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
