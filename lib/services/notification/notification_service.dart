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

  Future<int> getCurrentStep() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('ebbinghaus_step') ?? 0;
  }

  int getTotalSteps() {
    return [1, 3, 5].length;
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

    final List<int> delays = [1, 3, 5];

    // get current step from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentStep = prefs.getInt('ebbinghaus_step') ?? 0;

    if (currentStep >= delays.length) {
      currentStep = 0;
    }

    final int delay = delays[currentStep];
    final scheduledDate = now.add(Duration(seconds: delay));

    // check future date
    final safeScheduledDate = scheduledDate.isBefore(now)
        ? now.add(const Duration(seconds: 1))
        : scheduledDate;

    final notificationId = id + currentStep; // uid noti

    print(
        "Шаг ${currentStep + 1}: Уведомление запланировано через $delay секунд на $safeScheduledDate");

    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      title,
      "$body (шаг ${currentStep + 1})",
      safeScheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'delayed_channel_id',
          'Delayed Notifications',
          channelDescription: 'EbbiNoti',
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

    // inc step for next call
    await prefs.setInt('ebbinghaus_step', currentStep + 1);
  }

  // Cancel only the last scheduled notification
  Future<void> cancelNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? lastNotificationId = prefs.getInt('last_notification_id');

    if (lastNotificationId != null) {
      await flutterLocalNotificationsPlugin.cancel(lastNotificationId);
      print("Canceled notification with ID: $lastNotificationId");
    } else {
      print("No notification to cancel.");
    }
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
