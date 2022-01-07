import 'package:flutter/material.dart';
import 'package:money_management/screen/home/screen_home.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: ScreenHome(),
    );
  }
}
