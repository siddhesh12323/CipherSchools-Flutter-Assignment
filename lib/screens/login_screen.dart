import 'package:cipherschool_assignment_siddhesh/utilities/clickable_text.dart';
import 'package:flutter/material.dart';
import '../service/auth/auth_service.dart';
import '../utilities/button.dart';
import '../utilities/dialog.dart';
import '../utilities/textfield.dart';

class LoginPage extends StatelessWidget {
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  // email and password controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // login function
  void login(BuildContext context) async {
    // auth service
    AuthService _auth = AuthService();

    // login with email and password
    try {
      await _auth.signInWithEmailAndPassword(
          _emailController.text, _passwordController.text);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return MyDialog(title: "Log in failed!", content: " $e");
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text(
          "Sign In",
        ),
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 70,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // email textfield
            MyTextField(
              hintText: "Email",
              controller: _emailController,
              horizontalPadding: 25,
            ),
            const SizedBox(height: 10),
            // password textfield
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _passwordController,
              horizontalPadding: 25,
            ),
            const SizedBox(height: 20),
            // login button
            MyButton(
              text: "Login",
              onTap: () {
                login(context);
              },
            ),
            const SizedBox(height: 20),

            // register button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                ),
                MyClickableText(onTap: onTap, text: "Sign Up")
              ],
            )
          ],
        ),
      ),
    );
  }
}
