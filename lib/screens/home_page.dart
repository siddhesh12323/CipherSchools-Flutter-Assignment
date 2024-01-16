import 'package:cipherschool_assignment_siddhesh/service/firestore/transaction_service.dart';
import 'package:cipherschool_assignment_siddhesh/utilities/income_expense_chips.dart';
import 'package:cipherschool_assignment_siddhesh/utilities/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utilities/dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // auth and expense service
  final TransactionService _transactionService = TransactionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _topInfoBar(context),
          const SizedBox(height: 20),
          _filtersChipBar(),
          const SizedBox(height: 10),
          _seeAllTransactionsButton(),
          _buildTransactionsList(context),
        ],
      ),
    );
  }

  // filters chip bar
  Widget _filtersChipBar() {
    return SegmentedButton(
      segments: const [
        ButtonSegment(value: "Today", label: Text("Today")),
        ButtonSegment(value: "Week", label: Text("Week")),
        ButtonSegment(value: "Month", label: Text("Month")),
        ButtonSegment(value: "Year", label: Text("Year"))
      ],
      selected: const {"Today"},
    );
  }

  // see all transactions button
  Widget _seeAllTransactionsButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
            height: 0,
          ),
          const Text("Recent Transaction",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Spacer(),
          FilledButton.tonal(onPressed: () {}, child: const Text("See All")),
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
                          transaction: transaction,
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
      height: 340,
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
          _accountBalance(),
          const SizedBox(height: 20),
          _getIncomeExpenseStream(context),
        ],
      ),
    );
  }

  // expense and income
  Widget _getIncomeExpenseStream(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StreamBuilder(
            stream: _transactionService.getIncomeSumStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var income = snapshot.data!;
                return Expanded(
                    child: IncomeExpenseChip(
                        icon: "income",
                        label: "Income",
                        color: Colors.green,
                        amount: income));
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
        const SizedBox(width: 10),
        StreamBuilder(
            stream: _transactionService.getExpenseSumStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var expense = snapshot.data!;
                return Expanded(
                  child: IncomeExpenseChip(
                      icon: "expense",
                      label: "Expenses",
                      color: Colors.red,
                      amount: expense),
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ],
    );
  }

  // account balance
  Widget _accountBalance() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Account Balance",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.withOpacity(0.5))),
        const SizedBox(height: 10),
        StreamBuilder(
          stream: _transactionService.getNetWorthStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var netWorth = snapshot.data!;
              return Text(netWorth < 0 ? "₹ 0" : "₹ $netWorth",
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black));
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }

  // top navbar
  Widget _topnavbar(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // profile icon
        Image.asset("assets/images/avatar.png"),
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
              Text(
                DateFormat('MMMM').format(DateTime.now()),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
        ),
        // notification icon
        Image.asset("assets/images/notification.png"),
      ],
    );
  }
}
