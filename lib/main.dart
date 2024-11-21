import 'package:flutter/material.dart';
import 'login.dart';
void main() {
  runApp(const MyTaskApp());
}

class MyTaskApp extends StatelessWidget {
  const MyTaskApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Task',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Login(),
    );
  }
}
