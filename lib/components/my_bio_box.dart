import 'package:flutter/material.dart';

class MyBioBox extends StatelessWidget {
  final String text;
  const MyBioBox({super.key, required this.text});

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // Container
    return Container(
      // Padding outside
      margin: const EdgeInsets.symmetric(horizontal: 25),

      // Padding inside
      padding: const EdgeInsets.all(25),

      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,

          // Curve corners
          borderRadius: BorderRadius.circular(8)),

      child: Text(
        text.isNotEmpty ? text : "О себе..",
        style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
      ),
    );
  }
}
