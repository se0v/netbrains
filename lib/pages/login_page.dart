import 'package:flutter/material.dart';
import 'package:netbrains/components/my_button.dart';
import 'package:netbrains/components/my_loading_circle.dart';
import 'package:netbrains/components/my_text_field.dart';
import 'package:netbrains/services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginPage> {
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
        child: CustomScrollView(
          slivers: [
            // SliverAppBar + text
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: false,
              expandedHeight: (MediaQuery.of(context).size.height) / 4,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/blurr.jpg',
                  fit: BoxFit.cover,
                ),
                centerTitle: true,
                titlePadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                title: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Icons front of text
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Icon(Icons.forum, color: Colors.white),
                              Text('Форум',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ],
                          ),
                          SizedBox(width: 20), // Padding between icons
                          Column(
                            children: [
                              Icon(Icons.calendar_today, color: Colors.white),
                              Text('Расписание',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ],
                          ),
                          SizedBox(width: 20), // Same
                          Column(
                            children: [
                              Icon(Icons.article, color: Colors.white),
                              Text('Новости',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                          height: 20), // Padding between icons and text
                      Text(
                        "«BrainNet» — твой незаменимый помощник в учёбе",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 1 // thickness of outline
                            ..color = Colors.white, // color of outline
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
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
                          "Авторизоваться:",
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
                          height: 20,
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
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: Text(
                                "Зарегистрироваться",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
