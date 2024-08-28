import 'package:flutter/material.dart';
import 'package:netbrains/components/my_loading_circle.dart';
import 'package:netbrains/services/auth/auth_service.dart';
import 'package:netbrains/services/database/database_service.dart';

import '../components/my_button.dart';
import '../components/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // access auth & db service
  final _auth = AuthService();
  final _db = DatabaseService();

  // text controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  void register() async {
    // passwords match -> create user
    if (pwController.text == confirmPwController.text) {
      showLoadingCircle(context);

      // attempt to register new user
      try {
        await _auth.registerEmailPassword(
            emailController.text, pwController.text);

        if (mounted) hideLoadingCircle(context);

        // once registered, create and save user profile in database
        await _db.saveUserInfoInFirebase(
            name: nameController.text, email: emailController.text);
      } catch (e) {
        if (mounted) hideLoadingCircle(context);

        // let user know of the error
        if (mounted) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(e.toString()),
                  ));
        }
      }
    }
    // passwords don't match -> show error
    if (mounted) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Passwords dont't match!"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Icon(
                Icons.lock_open,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                height: 50,
              ),
              // Lets create an acc
              Text(
                "Let's create an account",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              // name textfield
              MyTextField(
                controller: nameController,
                hintText: "Enter name",
                obscureText: false,
              ),
              const SizedBox(
                height: 10,
              ),

              // email textfield
              MyTextField(
                controller: emailController,
                hintText: "Enter email",
                obscureText: false,
              ),
              const SizedBox(
                height: 10,
              ),

              // password textfield
              MyTextField(
                controller: pwController,
                hintText: "Enter password (6+ characters)",
                obscureText: true,
              ),
              const SizedBox(
                height: 10,
              ),

              // confirm password textfield
              MyTextField(
                controller: confirmPwController,
                hintText: "Confirm password",
                obscureText: true,
              ),
              const SizedBox(
                height: 25,
              ),
              // sign up button
              MyButton(text: "Register", onTap: register),
              const SizedBox(
                height: 50,
              ),
              // already a member?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already a member?",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    width: 5,
                  ),

                  // Login now
                  GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login now",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              )
            ],
          ),
        )),
      )),
    );
  }
}
