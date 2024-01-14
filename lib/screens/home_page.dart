import 'package:cipherschool_assignment_siddhesh/service/firestore/transaction_service.dart';
import 'package:cipherschool_assignment_siddhesh/utilities/transaction_tile.dart';
import 'package:flutter/material.dart';

import '../service/auth/auth_service.dart';
import '../utilities/dialog.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // auth and expense service
  final AuthService _auth = AuthService();
  final TransactionService _transactionService = TransactionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _topInfoBar(context),
          // const SizedBox(height: 20),
          //_filtersChipBar(),
          // const SizedBox(height: 20),
          //_seeAllTransactionsButton(),
          const SizedBox(height: 20),
          _buildTransactionsList(context),
        ],
      ),
    );
  }

  // build transactions list
  Widget _buildTransactionsList(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: _transactionService.getTransactionsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final transactions = snapshot.data!;
            return ListView(
                children: transactions.docs
                    .map<Widget>((transaction) => TransactionTile(
                          transactionCategory:
                              transaction["transactionCategory"],
                          transactionAmount: transaction["transactionAmount"],
                          transactionDescription:
                              transaction["transactionDescription"],
                          transactionTimestamp:
                              transaction["transactionTimestamp"],
                          isExpense: transaction["isExpense"],
                        ))
                    .toList());
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  // top info bar
  Widget _topInfoBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 350,
      // make the bottom right and left corners of the container rounded
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 253, 247, 235),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          _topnavbar(context),
          const SizedBox(height: 20),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Account Balance",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withOpacity(0.5))),
              const SizedBox(height: 10),
              Text("₹ ${0.0}",
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ],
          ),
        ],
      ),
    );
  }

  // top navbar
  Widget _topnavbar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // profile icon
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(Icons.person, color: Colors.white),
        ),
        // month filter
        InkWell(
          onTap: () {
            // show month filter dialog
            showDialog(
                context: context,
                builder: (context) {
                  return const MyDialog(
                      title: "Filter by Month",
                      content: "Will be implemented soon!");
                });
          },
          child: Row(
            children: [
              Icon(Icons.arrow_drop_down,
                  color: Theme.of(context).primaryColor),
              const SizedBox(width: 5),
              const Text(
                "May",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
        ),
        // notification icon
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(Icons.notifications, color: Colors.white),
        ),
      ],
    );
  }
}
