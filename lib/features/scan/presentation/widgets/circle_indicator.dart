import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CircleIndicator extends StatelessWidget {
  final int harmless;
  final int malicious;

  const CircleIndicator({
    super.key,
    required this.harmless,
    required this.malicious,
  });

  @override
  Widget build(BuildContext context) {
    final int total = harmless + malicious;
    final double percent = total == 0 ? 0 : malicious / total;

    return CircularPercentIndicator(
      radius: 60,
      lineWidth: 10,
      percent: percent.clamp(0, 1),
      animation: true,
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: malicious < 1
          ? Colors.green.withOpacity(0.1)
          : Colors.red.withOpacity(0.1),
      progressColor: malicious < 1
          ? Colors.green
          : Colors.redAccent, 
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            malicious.toString(),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: malicious < 1 ? Colors.green : Colors.redAccent,
            ),
          ),
          Text(
            "/ $total",
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
