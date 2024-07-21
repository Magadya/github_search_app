import 'package:flutter/material.dart';
import 'package:github_search_app/domain/extensions/extensions.dart';

import '../../../../core/resources/styles/colors.dart';

import '../../settings/theme/screens/theme_screen.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: defaultGray, fontSize: 25),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: const Text('Theme'),
            onTap: () => {
              context.pop(),
              context.push(const ThemeScreen()),
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: const Text('Settings'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
        ],
      ),
    );
  }
}
