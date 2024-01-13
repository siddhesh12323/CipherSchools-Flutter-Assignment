import 'package:cipherschool_assignment_siddhesh/utilities/my_clickable_text.dart';
import 'package:flutter/material.dart';

import '../service/auth/auth_service.dart';
import '../utilities/my_button.dart';
import '../utilities/my_dialog.dart';
import '../utilities/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // email and password controllers
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmpasswordController =
      TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  // signup function
  void signup(BuildContext context) async {
    // auth service
    AuthService _auth = AuthService();

    // signup with email and password
    if (_passwordController.text != _confirmpasswordController.text) {
      showDialog(
          context: context,
          builder: (context) {
            return const MyDialog(
                title: "Error!",
                content: "Please enter same password in both fields!");
          });
    } else {
      try {
        await _auth.registerWithEmailAndPassword(
            _emailController.text, _passwordController.text);
      } catch (e) {
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (context) {
              return MyDialog(title: "Sign up failed!", content: " $e");
            });
      }
    }
  }

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text(
          "Sign Up",
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
            // name textfield
            MyTextField(hintText: "Name", controller: _nameController),
            const SizedBox(height: 10),
            // email textfield
            MyTextField(hintText: "Email", controller: _emailController),
            const SizedBox(height: 10),
            // password textfield
            MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: _passwordController),
            const SizedBox(height: 10),
            // by signing up message checkbox
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 25),
                Checkbox(
                  activeColor: Theme.of(context).colorScheme.primary,
                  focusColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  value: _isChecked,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "By signing up you agree to our ",
                    ),
                    MyClickableText(
                        onTap: null,
                        text: "Terms of Service and Privacy Policy")
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // login button
            MyButton(
              text: "Sign Up",
              onTap: () {
                if (!_isChecked) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const MyDialog(
                            title: "Error!",
                            content:
                                "Please agree to our Terms of Service and Privacy Policy");
                      });
                  return;
                }
                signup(context);
              },
            ),
            const SizedBox(height: 10),
            const Text("Or with", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 10),
            // google button
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/google.png",
                      height: 50,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Sign Up with Google",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                // check if user has agreed to terms and conditions
                if (!_isChecked) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const MyDialog(
                            title: "Error!",
                            content:
                                "Please agree to our Terms of Service and Privacy Policy");
                      });
                  return;
                }
                AuthService auth = AuthService();
                // sign in with google
                auth.signInWithGoogle();
              },
            ),
            const SizedBox(height: 20),
            // register button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                ),
                MyClickableText(onTap: widget.onTap, text: "Log In"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
