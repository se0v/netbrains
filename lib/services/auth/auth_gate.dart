import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netbrains/services/auth/login_or_register.dart';

import '../../pages/home_page.dart';

/* 

AUTH GATE

This is to check if the user logged in or not
(-> to home page or login page / register page)

*/

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return const HomePage();
          }

          // user is NOT logged in
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
