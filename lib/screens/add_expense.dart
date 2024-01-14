import 'package:cipherschool_assignment_siddhesh/utilities/button.dart';
import 'package:cipherschool_assignment_siddhesh/utilities/textfield.dart';
import 'package:flutter/material.dart';

import '../service/auth/auth_service.dart';
import '../service/firestore/transaction_service.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  // cloud firestore service
  final TransactionService _transactionService = TransactionService();
  final AuthService _auth = AuthService();

  String expenseCategoriesDropdownValue = 'Subscription';
  String walletCategoriesDropdownValue = 'Wallet 1';
  TextEditingController _amountController = TextEditingController();
  TextEditingController _expenseDescriptionController = TextEditingController();
  List<String> _expenseCategories = [
    "Subscription",
    "Food",
    "Travel",
    "Shopping",
  ];

  List<String> _walletCategories = [
    "Wallet 1",
    "Wallet 2",
    "Wallet 3",
    "Wallet 4",
  ];

  void _addExpense() {
    // add expense to the database
    _transactionService.addTransaction(
        double.parse(_amountController.text),
        expenseCategoriesDropdownValue,
        _expenseDescriptionController.text,
        true);
  }

  Container _expenseAmount() {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 270,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "How much?",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Transform(
                    transform: Matrix4.translationValues(0, -7, 0),
                    child: const Text(
                      "₹",
                      style: TextStyle(
                        fontSize: 60,
                        color: Colors.white,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      style: const TextStyle(fontSize: 60, color: Colors.white),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "0",
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _dropdown(List<String> categories, String dropdownContext) {
    return Container(
      height: 60,
      // add a border to the container
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.of(context).size.width - 40,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            isExpanded: true,
            underline: const SizedBox(),
            icon: const Icon(Icons.arrow_drop_down),
            hint: const Text("Category"),
            value: dropdownContext == "expense"
                ? expenseCategoriesDropdownValue
                : walletCategoriesDropdownValue,
            style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.bold),
            items: categories.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                if (dropdownContext == "expense")
                  expenseCategoriesDropdownValue = newValue!;
                else
                  walletCategoriesDropdownValue = newValue!;
              });
            },
          )),
    );
  }

  Container _expenseInfo() {
    return Container(
      // make the top right and left corners of the container rounded
      height: MediaQuery.of(context).size.height - 400,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          // expense category
          _dropdown(_expenseCategories, "expense"),
          const SizedBox(height: 20),
          MyTextField(
            hintText: "Description",
            controller: _expenseDescriptionController,
            horizontalPadding: 20,
          ),
          const SizedBox(height: 20),
          _dropdown(_walletCategories, "wallet"),
          const SizedBox(height: 20),
          MyButton(
              text: "Continue",
              onTap: () {
                _addExpense();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Expense added successfully!"),
                  ),
                );
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Expense",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: const Color.fromARGB(255, 0, 119, 255),
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 0, 119, 255),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - 100,
          ),
          child: Stack(
            children: [
              _expenseAmount(),
              Align(
                alignment: Alignment.bottomCenter,
                child: _expenseInfo(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
