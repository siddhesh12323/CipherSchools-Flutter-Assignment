import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  const MyButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        height: 50,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            borderRadius: BorderRadius.circular(14)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18, color: Theme.of(context).colorScheme.background),
          ),
        ),
      ),
    );
  }
}
