import 'package:flutter/material.dart';

class MySettingsTile extends StatelessWidget {
  final String title;
  final Widget action;
  const MySettingsTile({super.key, required this.title, required this.action});

  @override
  Widget build(BuildContext context) {
    // Container
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),

      // Padding outside
      margin: const EdgeInsets.only(left: 25, right: 25, top: 10),

      // Padding inside
      padding: const EdgeInsets.all(25),

      // Row
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          action,
        ],
      ),
    );
  }
}
