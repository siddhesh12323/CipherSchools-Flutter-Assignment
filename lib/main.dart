import 'package:cipherschool_assignment_siddhesh/firebase_options.dart';
import 'package:cipherschool_assignment_siddhesh/screens/add_expense.dart';
import 'package:cipherschool_assignment_siddhesh/screens/add_income.dart';
import 'package:cipherschool_assignment_siddhesh/service/auth/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/navigation_page.dart';
import 'screens/profile_page.dart';

/*
  Test Credentials:
  Email: testuser1@gmail.com
  Password: 12345678
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CipherSchools Assignment',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const AuthGate(),
        '/home': (context) => const NavigationPage(),
        '/add_expense': (context) => const AddExpense(),
        '/add_income': (context) => const AddIncome(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
