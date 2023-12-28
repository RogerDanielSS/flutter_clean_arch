import 'package:flutter/material.dart';

import '../pages/pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromRGBO(136, 14, 79, 1);
    const primaryColorDark = Color.fromRGBO(136, 0, 39, 1);
    const primaryColorLight = Color.fromRGBO(188, 71, 213, 1);

    return MaterialApp(
      title: 'MrRoganTano',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: primaryColor,
          primaryColorDark: primaryColorDark,
          primaryColorLight: primaryColorLight,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: primaryColor, background: Colors.white)),
      home: const LoginPage(),
    );
  }
}
