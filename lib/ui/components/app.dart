import 'package:flutter/material.dart';

import '../pages/pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MrRoganTano',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
