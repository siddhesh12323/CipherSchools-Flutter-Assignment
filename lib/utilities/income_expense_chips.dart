import 'package:flutter/material.dart';

class IncomeExpenseChip extends StatelessWidget {
  final String icon;
  final String label;
  final double amount;
  final Color color;
  const IncomeExpenseChip(
      {super.key,
      required this.icon,
      required this.label,
      required this.amount,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assets/images/$icon.png"),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text(
                  label,
                  style: TextStyle(color: Colors.white),
                ),
                Text("₹ $amount",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
