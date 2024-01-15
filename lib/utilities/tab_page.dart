import 'package:flutter/material.dart';

class TabPage extends StatelessWidget {
  final String pageName;
  const TabPage({super.key, required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("This is $pageName page"),
      ),
    );
  }
}
