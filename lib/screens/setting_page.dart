import 'package:first_app/configs/locale_config.dart';
import 'package:first_app/configs/theme_config.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget{
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>{

  @override
  Widget build(BuildContext context){
    return ListView(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Page Setting',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.green),
        ),
        const SizedBox(height: 16),
        const Text(
          'Important',
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        // Switch pour le thème
        ValueListenableBuilder<ThemeMode>(
          valueListenable: ThemeConfig.themeNotifier,
          builder: (context, currentTheme, _) {
            return SwitchListTile(
              title: const Text('Mode sombre'),
              value: currentTheme == ThemeMode.dark,
              onChanged: ThemeConfig.toggleTheme,
              /*onChanged: (value) {
                ThemeConfig.themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
              },*/
            );
          },
        ),

          // Dropdown pour la langue
          ValueListenableBuilder<Locale>(
            valueListenable: LocaleConfig.localeNotifier,
            builder: (context, currentLocale, _) {
              return ListTile(
                title: const Text('Langue'),
                trailing: DropdownButton<Locale>(
                  value: currentLocale,
                  items: const [
                    DropdownMenuItem(value: Locale('en'), child: Text('English')),
                    DropdownMenuItem(value: Locale('fr'), child: Text('Français')),
                  ],
                  onChanged: (value) {
                    if (value != null) LocaleConfig.localeNotifier.value = value;
                  },
                ),
              );
            },
          ),
      ],
    );
  }
}