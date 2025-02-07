import 'package:fateen/screens/login_screen.dart';
import 'package:flutter/material.dart';

/*
void main() {
  runApp(const MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), // ThemeData
      home: const LoginScreen(),
    ); // MaterialApp
  }
}

*/

import 'package:flutter/material.dart';
import 'screens/file_screen.dart'; // استيراد شاشة الملفات

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'File Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FileScreen(), // تشغيل شاشة الملفات مباشرة
    );
  }
}
