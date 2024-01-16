import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final bool isAtExtremeEnd;
  final String? topOrBottom;
  final String title;
  final String icon;
  final void Function()? onTap;
  const SettingsTile(
      {super.key,
      required this.isAtExtremeEnd,
      required this.title,
      required this.onTap,
      required this.icon,
      this.topOrBottom});

  @override
  Widget build(BuildContext context) {
    return isAtExtremeEnd
        ? GestureDetector(
            onTap: onTap,
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: (topOrBottom == "top")
                    ? BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )
                    : BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 20),
                  Image.asset(
                    "assets/images/$icon.png",
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(width: 20),
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          )
        : GestureDetector(
            onTap: onTap,
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 20),
                  Image.asset(
                    "assets/images/$icon.png",
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(width: 20),
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          );
  }
}
