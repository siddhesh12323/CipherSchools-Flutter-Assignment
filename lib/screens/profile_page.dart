import 'package:cipherschool_assignment_siddhesh/service/auth/auth_service.dart';
import 'package:cipherschool_assignment_siddhesh/service/firestore/transaction_service.dart';
import 'package:cipherschool_assignment_siddhesh/utilities/settings_tile.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // transaction service and auth service
  final TransactionService transactionService = TransactionService();
  final AuthService authService = AuthService();

  // logout user
  void logoutUser() {
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            _topNavBar(context),
            const SizedBox(height: 40),
            // settings tiles
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SettingsTile(
                      isAtExtremeEnd: true,
                      topOrBottom: "top",
                      title: "Account",
                      onTap: null,
                      icon: "account"),
                  const SizedBox(
                    height: 1,
                  ),
                  const SettingsTile(
                      isAtExtremeEnd: false,
                      title: "Settings",
                      onTap: null,
                      icon: "settings"),
                  const SizedBox(
                    height: 1,
                  ),
                  const SettingsTile(
                      isAtExtremeEnd: false,
                      title: "Export Data",
                      onTap: null,
                      icon: "export_data"),
                  const SizedBox(
                    height: 1,
                  ),
                  SettingsTile(
                      isAtExtremeEnd: true,
                      topOrBottom: "bottom",
                      title: "Logout",
                      onTap: logoutUser,
                      icon: "logout"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // top navbar
  Widget _topNavBar(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Image.asset(
        "assets/images/avatar_big.png",
        height: 80,
        width: 80,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Username",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 5),
          StreamBuilder(
              stream: transactionService.getUsersStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final usersList = snapshot.data!;
                  print(authService.currentUser!.email);
                  if (usersList.isNotEmpty) {
                    for (var user in usersList) {
                      if (user['email'] == authService.currentUser!.email) {
                        return Text(user['name'],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold));
                      } else {
                        return const SizedBox.shrink();
                      }
                    }
                  } else {
                    return const SizedBox.shrink();
                  }
                } else {
                  return const SizedBox.shrink();
                }
                return const Text("Loading...");
              }),
        ],
      ),
      Image.asset("assets/images/edit.png")
    ]);
  }
}
