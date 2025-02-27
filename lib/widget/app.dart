import 'package:flutter/material.dart';

import 'home.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SQL ito",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: Colors.deepOrange,
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
