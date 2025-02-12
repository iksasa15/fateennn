import 'package:flutter/material.dart';
import 'login_screen.dart'; // ✅ استيراد شاشة تسجيل الدخول

class HomeScreen extends StatelessWidget {
  final String userName;

  const HomeScreen({super.key, required this.userName});

  // ✅ وظيفة تسجيل الخروج التي تعيد المستخدم إلى شاشة تسجيل الدخول
  void logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة الرئيسية'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context), // ✅ زر تسجيل الخروج
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'مرحباً بك يا $userName!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => logout(context), // ✅ زر تسجيل الخروج
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('تسجيل خروج'),
            ),
          ],
        ),
      ),
    );
  }
}
