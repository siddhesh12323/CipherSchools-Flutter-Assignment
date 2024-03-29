import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

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

  // get the name of the current user
  Future<String> getCurrentUserName() async {
    // get current user id
    final currentUserID = _auth.currentUser!.uid;

    // get current user name from firestore
    final currentUser = await _firestore
        .collection('Users')
        .doc(currentUserID)
        .get()
        .then((value) => value.data());

    // return current user name
    return currentUser!['name'];
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

  Stream<double> getIncomeSumStream() {
    final DateTime now = DateTime.now();
    return FirebaseFirestore.instance
        .collection('Transactions')
        .doc(_auth.currentUser!.uid)
        .collection('UserTransactions')
        .where('isExpense', isEqualTo: false)
        .where('transactionTimestamp',
            isGreaterThanOrEqualTo:
                Timestamp.fromDate(DateTime(now.year, now.month, 1)))
        .where('transactionTimestamp',
            isLessThan:
                Timestamp.fromDate(DateTime(now.year, now.month + 1, 1)))
        .snapshots()
        .map((querySnapshot) {
      double incomeSum = 0;
      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in querySnapshot.docs) {
        incomeSum += (document['transactionAmount'] ?? 0);
      }
      return incomeSum;
    });
  }

  Stream<double> getExpenseSumStream() {
    final DateTime now = DateTime.now();
    return FirebaseFirestore.instance
        .collection('Transactions')
        .doc(_auth.currentUser!.uid)
        .collection('UserTransactions')
        .where('isExpense', isEqualTo: true)
        .where('transactionTimestamp',
            isGreaterThanOrEqualTo:
                Timestamp.fromDate(DateTime(now.year, now.month, 1)))
        .where('transactionTimestamp',
            isLessThan:
                Timestamp.fromDate(DateTime(now.year, now.month + 1, 1)))
        .snapshots()
        .map((querySnapshot) {
      double expenseSum = 0;
      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in querySnapshot.docs) {
        expenseSum += (document['transactionAmount'] ?? 0).toDouble();
      }
      return expenseSum;
    });
  }

  Stream<double> getNetWorthStream() {
    Stream<double> incomeStream = getIncomeSumStream();
    Stream<double> expenseStream = getExpenseSumStream();

    return Rx.combineLatest2(
      incomeStream,
      expenseStream,
      (double income, double expense) => income - expense,
    );
  }
}
