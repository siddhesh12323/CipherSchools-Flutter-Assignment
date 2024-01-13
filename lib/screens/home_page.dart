import 'package:cipherschool_assignment_siddhesh/utilities/transaction_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void onDelete() {
    print("Delete");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TransactionTile(
              category: "Shopping",
              time: "10:00 AM",
              onPressed: onDelete,
              amount: "1200",
              description: "Disney + Annual subscription",
              isExpense: true)
        ],
      ),
    );
  }
}
