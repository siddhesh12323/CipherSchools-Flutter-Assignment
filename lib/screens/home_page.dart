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

  // add transaction function
  void addTransaction(double transactionAmount, String transactionCategory,
      String transactionDescription, bool isExpense) async {
    // add transaction
    await _transactionService.addTransaction(transactionAmount,
        transactionCategory, transactionDescription, isExpense);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _topInfoBar(context),
          const SizedBox(height: 20),
          //_filtersChipBar(),
          const SizedBox(height: 20),
          //_seeAllTransactionsButton(),
          const SizedBox(height: 20),
          _buildTransactionsList(),
        ],
      ),
    );
  }

  // build transactions list
  Widget _buildTransactionsList() {
    return Expanded(
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _transactionService.getTransactionsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final transactions = snapshot.data!;
            return ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return TransactionTile(
                  transactionAmount: transactions[index]['transactionAmount'],
                  transactionCategory: transactions[index]
                      ['transactionCategory'],
                  transactionDescription: transactions[index]
                      ['transactionDescription'],
                  transactionTimestamp: transactions[index]
                      ['transactionTimestamp'],
                  isExpense: transactions[index]['isExpense'],
                );
              },
            );
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
      height: 300,
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
            color: Colors.black,
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
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(Icons.notifications, color: Colors.white),
        ),
      ],
    );
  }
}
