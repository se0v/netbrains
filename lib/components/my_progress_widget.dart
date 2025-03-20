import 'package:flutter/material.dart';

class MyProgressWidget extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const MyProgressWidget({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    double progress = (totalSteps > 0) ? currentStep / totalSteps : 0.0;

    return Column(
      children: [
        Text(
          "Прогресс повторения: шаг $currentStep из $totalSteps",
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          color: Colors.blue,
          minHeight: 10,
        ),
      ],
    );
  }
}
