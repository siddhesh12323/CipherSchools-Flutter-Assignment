import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionService {
  // get instance of cloud firestore and auth
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  // add transaction
  Future<void> addTransaction(
      double transactionAmount,
      String transactionCategory,
      String transactionDescription,
      bool isExpense) async {
    // get current user id
    final currentUserID = _auth.currentUser!.uid;
    final currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // construct transaction object
    final newTransaction = {
      'userID': currentUserID,
      'userEmail': currentUserEmail,
      'transactionCategory': transactionCategory,
      'transactionAmount': transactionAmount,
      'transactionDescription': transactionDescription,
      'transactionTimestamp': timestamp,
      'isExpense': isExpense
    };

    // add transaction to firestore
    await _firestore
        .collection('Transactions')
        .doc(currentUserID)
        .collection('UserTransactions')
        .add(newTransaction);
  }

  // delete transaction
  Future<void> deleteTransaction(String transactionID) async {
    // get current user id
    final currentUserID = _auth.currentUser!.uid;

    // delete transaction from firestore
    await _firestore
        .collection('Transactions')
        .doc(currentUserID)
        .collection('UserTransactions')
        .doc(transactionID)
        .delete();
  }

  // get transaction stream
  Stream<QuerySnapshot> getTransactionsStream() {
    // return _firestore.collection('Users').snapshots().map((snapshot) {
    //     return snapshot.docs.map((doc) => doc.data()).toList();
    //   });
    final currentUserID = _auth.currentUser!.uid;
    // get transactions stream from firestore for current user
    return _firestore
        .collection('Transactions')
        .doc(currentUserID)
        .collection('UserTransactions')
        .snapshots();
  }
}
