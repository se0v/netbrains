import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netbrains/components/my_settings_tile.dart';
import 'package:netbrains/themes/theme_provider.dart';
import 'package:provider/provider.dart';

import '../components/my_drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // SCAFFOLD
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        drawer: MyDrawer(),
        // App Bar
        appBar: AppBar(
          title: const Text("Н А С Т Р О Й К И"),
          foregroundColor: Theme.of(context).colorScheme.primary,
        ),

        // Body
        body: Column(
          children: [
            // Dark mode tile
            MySettingsTile(
              title: "Тёмная тема",
              action: CupertinoSwitch(
                onChanged: (value) =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme(),
                value: Provider.of<ThemeProvider>(context, listen: false)
                    .isDarkMode,
              ),
            )
            // Block users tile

            // Account settings tile
          ],
        ));
  }
}
