import 'package:flutter/material.dart';
import 'package:netbrains/components/my_drawer_tile.dart';
import 'package:netbrains/pages/profile_page.dart';
import 'package:netbrains/pages/schedule_page.dart';
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              // app logo
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    imagePath,
                    width: 144,
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

              // news list tile
              MyDrawerTile(
                title: "Н О В О С Т И",
                icon: Icons.newspaper_rounded,
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SchedulePage()));
                },
              ),

              // home list tile
              MyDrawerTile(
                title: "Ф О Р У М",
                icon: Icons.public,
                onTap: () {
                  Navigator.pop(context);
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

              // literature list tile
              MyDrawerTile(
                title: "Л И Т Е Р А Т У Р А",
                icon: Icons.book_outlined,
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

              const Spacer(),
              // logout list tile
              MyDrawerTile(
                  title: "В Ы Х О Д", icon: Icons.logout, onTap: logout)
            ],
          ),
        ),
      ),
    );
  }
}
