import 'package:cipherschool_assignment_siddhesh/utilities/clickable_text.dart';
import 'package:flutter/material.dart';

import '../service/auth/auth_service.dart';
import '../utilities/button.dart';
import '../utilities/dialog.dart';
import '../utilities/textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // email and password controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  // signup function
  void signup(BuildContext context) async {
    // auth service
    // ignore: no_leading_underscores_for_local_identifiers
    AuthService _auth = AuthService();

    // signup with email and password
    try {
      await _auth.registerWithEmailAndPassword(_emailController.text,
          _passwordController.text, _nameController.text);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return MyDialog(title: "Sign up failed!", content: " $e");
          });
    }
  }

  // checkbox value
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // name textfield
              MyTextField(
                hintText: "Name",
                controller: _nameController,
                horizontalPadding: 25,
              ),
              const SizedBox(height: 10),
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
                  signup(context);
                },
              ),
              const SizedBox(height: 10),
              const Text("Or with", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 10),
              // google sign up button
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
                  // auth service
                  AuthService auth = AuthService();
                  // sign in with google
                  auth.signInWithGoogle();
                },
              ),
              const SizedBox(height: 20),
              // already have an account text
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
      ),
    );
  }
}
