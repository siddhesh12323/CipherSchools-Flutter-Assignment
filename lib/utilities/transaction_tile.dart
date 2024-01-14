import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../service/firestore/transaction_service.dart';

class TransactionTile extends StatelessWidget {
  final String transactionCategory;
  final Timestamp transactionTimestamp;
  final double transactionAmount;
  final String transactionDescription;
  final bool isExpense;

  TransactionTile({
    super.key,
    required this.transactionCategory,
    required this.transactionTimestamp,
    required this.transactionAmount,
    required this.transactionDescription,
    required this.isExpense,
  });

  // get instance of expense service
  final TransactionService _expenseService = TransactionService();

  // delete transaction function, pass this function a timestamp as transactionID
  void deleteTransaction(String transactionID) async {
    // delete transaction
    await _expenseService.deleteTransaction(transactionID);
  }

  // get image based on transaction category
  Container _getImage() {
    String transactionImage = '';
    if (transactionCategory == "Shopping") {
      transactionImage = "assets/images/shopping-bag.png";
    } else if (transactionCategory == "Subscription") {
      transactionImage = "assets/images/recurring-bill.png";
    } else if (transactionCategory == "Food") {
      transactionImage = "assets/images/restaurant.png";
    } else if (transactionCategory == "Travel") {
      transactionImage = "assets/images/car.png";
    } else if (transactionCategory == "Other") {
      transactionImage = "assets/images/other.jpg";
    }
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Center(
        child: Image.asset(
          transactionImage,
          height: 30,
          width: 30,
        ),
      ),
    );
  }

  // get transaction category and description
  Column _getTransactionCategoryAndDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          transactionCategory,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          transactionDescription,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // get transaction amount and timestamp in am pm format
  Column _getTransactionAmountAndTimestamp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          isExpense ? "- ₹$transactionAmount" : "+ ₹$transactionAmount",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isExpense ? Colors.red : Colors.green,
          ),
        ),
        const SizedBox(height: 5),
        // show the transactionTimestamp in am pm format
        Text(
          DateFormat.jm().format(transactionTimestamp.toDate()),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              // show dialog for delete confirmation
              showDialog(
                context: context,
                builder: (context) {
                  return Center(
                      child: AlertDialog(
                    title: const Text("Delete transaction?"),
                    content: const Text(
                        "Are you sure you want to delete this transaction?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // delete transaction
                          //! CHECK THIS!
                          deleteTransaction(transactionTimestamp.toString());
                          Navigator.pop(context);
                        },
                        child: const Text("OK"),
                      )
                    ],
                  ));
                },
              );
            },
            label: 'Delete',
            backgroundColor: Colors.red,
            icon: Icons.delete,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getImage(),
            const SizedBox(width: 10),
            _getTransactionCategoryAndDescription(),
            const Spacer(),
            _getTransactionAmountAndTimestamp(),
          ],
        ),
      ),
    );
  }
}
