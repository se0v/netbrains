import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // SCAFFOLD
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      // App Bar
      appBar: AppBar(
        title: const Text("S C H E D U L E"),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      // Body
      body: Center(
        child: Text(
          "Coming soon..",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
