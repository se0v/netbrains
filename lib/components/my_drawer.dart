import 'package:flutter/material.dart';
import 'package:netbrains/components/my_drawer_tile.dart';
import 'package:netbrains/pages/home_page.dart';
import 'package:netbrains/pages/news_page.dart';
import 'package:netbrains/pages/notes_page.dart';
import 'package:netbrains/pages/profile_page.dart';
import 'package:netbrains/pages/schedule_page.dart';
import 'package:netbrains/services/auth/auth_gate.dart';
import 'package:netbrains/services/auth/auth_service.dart';
import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  // access auth service
  final _auth = AuthService();

  // logout
  void logout() {
    _auth.logout();
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // recognize current theme
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // choose image theme
    final String imagePath = isDarkMode
        ? 'assets/draweric3.jpg' // dark theme
        : 'assets/draweric2.jpg'; // light theme
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          children: [
            // app logo
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(122.0),
                child: Image.asset(
                  imagePath,
                  width: 164,
                  height: 164,
                ),
              ),
            ),

            Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),

            const SizedBox(height: 10),

            // profile list tile
            MyDrawerTile(
              title: "П Р О Ф И Л Ь",
              icon: Icons.person,
              onTap: () {
                // pop menu drawer
                Navigator.pop(context);

                // go to profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProfilePage(uid: _auth.getCurrentUid()),
                  ),
                );
              },
            ),

            // Ebbinghaus list tile
            MyDrawerTile(
                title: "З А М Е Т К И",
                icon: Icons.now_widgets_outlined,
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NotesPage(uid: _auth.getCurrentUid())));
                }),

            // news list tile
            MyDrawerTile(
              title: "Н О В О С Т И",
              icon: Icons.newspaper_rounded,
              onTap: () {
                Navigator.pop(context);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewsPage()));
              },
            ),

            // home list tile
            MyDrawerTile(
              title: "Ф О Р У М",
              icon: Icons.public,
              onTap: () {
                Navigator.pop(context);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),

            // schedule list tile
            MyDrawerTile(
              title: "Р А С П И С А Н И Е",
              icon: Icons.edit_calendar,
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SchedulePage()));
              },
            ),

            // search list tile

            // settings list tile
            MyDrawerTile(
              title: "Н А С Т Р О Й К И",
              icon: Icons.settings,
              onTap: () {
                // pop menu drawer
                Navigator.pop(context);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ));
              },
            ),

            Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
            // logout list tile
            MyDrawerTile(
              title: "В Ы Х О Д",
              icon: Icons.logout,
              onTap: () {
                logout();
                // pop menu drawer
                Navigator.pop(context);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthGate(),
                  ),
                  (Route<dynamic> route) =>
                      false, // Удаляет все предыдущие страницы
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
