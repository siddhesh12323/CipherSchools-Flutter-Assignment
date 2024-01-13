import 'package:flutter/material.dart';

class TabPage extends StatelessWidget {
  final int tab;
  const TabPage({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tab $tab"),
      ),
      body: Center(
        child: Text("Tab $tab"),
      ),
    );
  }
}
