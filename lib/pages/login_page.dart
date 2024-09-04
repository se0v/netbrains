import 'package:flutter/material.dart';
import 'package:netbrains/components/my_button.dart';
import 'package:netbrains/components/my_loading_circle.dart';
import 'package:netbrains/components/my_text_field.dart';
import 'package:netbrains/services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // access auth service
  final _auth = AuthService();

  // text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  // login method
  void login() async {
    // show loading circle
    showLoadingCircle(context);

    try {
      await _auth.loginEmailPassword(emailController.text, pwController.text);

      // finished loading
      if (mounted) hideLoadingCircle(context);
    } catch (e) {
      // finished loading
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
                Icons.login,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                height: 50,
              ),
              // Welcome back message
              Text(
                "С возвращением!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              // email textfield
              MyTextField(
                controller: emailController,
                hintText: "Почта",
                obscureText: false,
              ),
              const SizedBox(
                height: 10,
              ),
              // password textfield
              MyTextField(
                controller: pwController,
                hintText: "Пароль",
                obscureText: true,
              ),
              const SizedBox(
                height: 10,
              ),
              // forgot password
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Забыли пароль?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // sign in button
              MyButton(
                text: "Войти",
                onTap: login,
              ),
              const SizedBox(
                height: 50,
              ),
              // not a member
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Нет аккаунта?",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Зарегистрироваться",
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
