import 'package:cloud_firestore/cloud_firestore.dart';

class Transaction {
  final String userID;
  final String userEmail;
  final String transactionCategory;
  final double transactionAmount;
  final String transactionDescription;
  final bool isExpense;
  final Timestamp transactionTimestamp;

  Transaction(
      {required this.userID,
      required this.userEmail,
      required this.transactionCategory,
      required this.transactionAmount,
      required this.transactionDescription,
      required this.transactionTimestamp,
      required this.isExpense});

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'userEmail': userEmail,
      'transactionCategory': transactionCategory,
      'transactionAmount': transactionAmount,
      'transactionDescription': transactionDescription,
      'transactionTimestamp': transactionTimestamp,
      'isExpense': isExpense
    };
  }
}
