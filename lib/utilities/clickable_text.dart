import 'package:flutter/material.dart';

class MyClickableText extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const MyClickableText({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 15, color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
