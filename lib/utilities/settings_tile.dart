// import 'package:flutter/material.dart';

// class SettingsTile extends StatelessWidget {
//   final String icon;
//   final String title;
//   final Function? onTap;
//   const SettingsTile(
//       {super.key,
//       required this.icon,
//       required this.title,
//       required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (onTap != null) {
//           onTap!();
//         }
//       },
//       child: Container(
//         color: Theme.of(context).colorScheme.background,
//         child: Row(
//           children: [
//             const SizedBox(
//               width: 20,
//             ),
//             Image.asset(
//               "assets/images/$icon.png",
//               height: 40,
//               width: 40,
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             Text(
//               title,
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
