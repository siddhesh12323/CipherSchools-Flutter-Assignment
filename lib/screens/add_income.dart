// ignore_for_file: prefer_final_fields

import 'package:cipherschool_assignment_siddhesh/utilities/button.dart';
import 'package:cipherschool_assignment_siddhesh/utilities/textfield.dart';
import 'package:flutter/material.dart';

import '../service/firestore/transaction_service.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  // get transaction service
  final TransactionService _transactionService = TransactionService();

  // dropdown values
  String incomeCategoriesDropdownValue = 'Benefits';
  String walletCategoriesDropdownValue = 'Wallet 1';
  TextEditingController _amountController = TextEditingController();
  TextEditingController _incomeDescriptionController = TextEditingController();

  // income categories
  List<String> _incomeCategories = [
    "Benefits",
    "Salary",
    "Refunds",
    "Gifts",
  ];

  // wallet categories
  List<String> _walletCategories = [
    "Wallet 1",
    "Wallet 2",
    "Wallet 3",
    "Wallet 4",
  ];

  // add income to firestore
  void _addIncome() async {
    await _transactionService.addTransaction(
        double.parse(_amountController.text),
        incomeCategoriesDropdownValue,
        _incomeDescriptionController.text,
        false);
  }

  // get income amount
  Container _incomeAmount() {
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

  // dropdown
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
            value: dropdownContext == "income"
                ? incomeCategoriesDropdownValue
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
                if (dropdownContext == "income") {
                  incomeCategoriesDropdownValue = newValue!;
                } else {
                  walletCategoriesDropdownValue = newValue!;
                }
              });
            },
          )),
    );
  }

  // income info
  Container _incomeInfo() {
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
          // income category
          _dropdown(_incomeCategories, "income"),
          const SizedBox(height: 20),
          MyTextField(
            hintText: "Description",
            controller: _incomeDescriptionController,
            horizontalPadding: 20,
          ),
          const SizedBox(height: 20),
          _dropdown(_walletCategories, "wallet"),
          const SizedBox(height: 20),
          MyButton(
              text: "Continue",
              onTap: () {
                _addIncome();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Income added successfully!"),
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
          "Income",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: const Color.fromARGB(255, 123, 97, 255),
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 123, 97, 255),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - 100,
          ),
          child: Stack(
            children: [
              _incomeAmount(),
              Align(
                alignment: Alignment.bottomCenter,
                child: _incomeInfo(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
