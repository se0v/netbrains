import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:netbrains/firebase_options.dart';
import 'package:netbrains/services/auth/auth_gate.dart';
import 'package:netbrains/services/database/database_provider.dart';
import 'package:netbrains/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  // firebase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // create instance ThemeProvider and load save theme
  final themeProvider = ThemeProvider();
  // wait load theme
  await themeProvider.loadTheme();

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
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
