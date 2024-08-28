import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netbrains/components/my_settings_tile.dart';
import 'package:netbrains/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // SCAFFOLD
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        // App Bar
        appBar: AppBar(
          title: const Text("S E T T I N G S"),
          foregroundColor: Theme.of(context).colorScheme.primary,
        ),

        // Body
        body: Column(
          children: [
            // Dark mode tile
            MySettingsTile(
              title: "Dark mode",
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
