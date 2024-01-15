import 'package:flutter/material.dart';

class IncomeExpenseChip extends StatelessWidget {
  final String icon;
  final String label;
  final Color color;
  final double amount;
  const IncomeExpenseChip(
      {super.key,
      required this.icon,
      required this.label,
      required this.color,
      required this.amount});

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
                  style: const TextStyle(color: Colors.white),
                ),
                Center(
                    child: Text("₹ $amount",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
