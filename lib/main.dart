import 'package:collection/collection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netbrains/models/note.dart';
import 'package:netbrains/pages/notification_page.dart';
import 'package:netbrains/services/auth/auth_gate.dart';
import 'package:netbrains/services/database/database_provider.dart';
import 'package:netbrains/services/notification/notification_service.dart';
import 'package:netbrains/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  // firebase setup
  WidgetsFlutterBinding.ensureInitialized();

  // Установка предпочтений ориентации
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp();

  // create instance ThemeProvider and load save theme
  final themeProvider = ThemeProvider();
  // wait load theme
  await themeProvider.loadTheme();

  // launch notiService
  NotificationService notificationService = NotificationService();
  await notificationService.initNotification();

  // run app
  runApp(MultiProvider(
    providers: [
      // theme provider
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      // database provider
      ChangeNotifierProvider(create: (context) => DatabaseProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      navigatorKey: navigatorKey,
      routes: {
        '/notification_screen': (context) {
          final noteText =
              ModalRoute.of(context)?.settings.arguments as String?;

          if (noteText == null) {
            return const Scaffold(
              body: Center(child: Text("Ошибка: текст заметки не передан")),
            );
          }

          // Получаем доступ к базе данных
          final databaseProvider =
              Provider.of<DatabaseProvider>(context, listen: false);

          // Ищем заметку по noteId (без ошибки)
          final Note? note = databaseProvider.allNotes.firstWhereOrNull(
            (note) => note.note == noteText,
          );

          if (note == null) {
            return const Scaffold(
              body: Center(child: Text("Ошибка: Заметка не найдена")),
            );
          }

          return NotificationPage(note: note);
        },
      },
      theme: Provider.of<ThemeProvider>(context).themeData,
      // localization
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ],
    );
  }
}
