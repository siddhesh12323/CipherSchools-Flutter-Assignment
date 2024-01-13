import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TransactionTile extends StatelessWidget {
  final String category;
  final String time;
  final String amount;
  final String description;
  final bool isExpense;
  final Function() onPressed;
  const TransactionTile(
      {super.key,
      required this.category,
      required this.time,
      required this.amount,
      required this.description,
      required this.isExpense,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              onPressed;
            },
            label: 'Delete',
            backgroundColor: Colors.red,
            icon: Icons.delete,
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(14)),
                  child: Center(
                    child: Text(
                      category[0],
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.background),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      time,
                      style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount,
                  style: TextStyle(
                      fontSize: 18,
                      color: isExpense
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).colorScheme.secondary),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  description,
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
