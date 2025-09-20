import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wabiz_app/router.dart';
import 'package:wabiz_app/shared/shared_pref_provider.dart';
import 'package:wabiz_app/theme.dart';
import 'package:wabiz_app/views/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final pref = await SharedPreferences.getInstance();


  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(pref),
      ],
      child: MainApp()
    )
  );
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'wabiz',
      theme: wabizDefaultTheme,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      routerConfig: router,
      themeAnimationStyle: AnimationStyle(
        curve: Curves.easeInCirc,
        duration: Duration(milliseconds: 350),
      ),
    );
  }
}



