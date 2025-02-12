/*
import 'package:fateen/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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
import 'screens/login_screen.dart'; // ✅ شاشة تسجيل الدخول
import 'screens/home_screen.dart'; // ✅ الشاشة الرئيسية
import 'screens/task_screen.dart';
import 'screens/course_screen.dart';
import 'screens/reminder_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fateen Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(), // ✅ يجب تسجيل الدخول أولًا
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String userName; // ✅ استقبال اسم المستخدم بعد تسجيل الدخول
  const HomeScreen({super.key, required this.userName});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // ✅ قائمة الصفحات التي سيتم التنقل بينها
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      MainPage(userName: widget.userName), // ✅ تمرير اسم المستخدم
      TaskScreen(),
      CourseScreen(),
      ReminderScreen(),
    ];
  }

  // ✅ تحديث الصفحة عند تغيير التاب
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // ✅ تسجيل الخروج وإعادة المستخدم إلى `LoginScreen`
  void logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          [
            '📌 الرئيسية',
            '📋 المهام',
            '📚 المقررات',
            '🔔 التذكيرات'
          ][_selectedIndex],
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout, // ✅ عند الضغط يتم تسجيل الخروج
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Fateen Task Manager',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'مرحبًا، ${widget.userName} 👋', // ✅ عرض اسم المستخدم
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('الرئيسية'),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.task),
              title: const Text('المهام'),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('المقررات'),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('التذكيرات'),
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('تسجيل الخروج',
                  style: TextStyle(color: Colors.red)),
              onTap: logout, // ✅ تسجيل الخروج من القائمة الجانبية
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex], // ✅ عرض الصفحة الحالية
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'المهام'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'المقررات'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'التذكيرات'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

// ✅ الصفحة الرئيسية (بتصميم جديد)
class MainPage extends StatelessWidget {
  final String userName; // ✅ استقبال اسم المستخدم

  const MainPage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade200, Colors.blue.shade500],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.task_alt, size: 100, color: Colors.white),
            const SizedBox(height: 20),
            Text(
              'مرحبًا بك، $userName! 🎉', // ✅ الترحيب بالمستخدم باسمه
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'إدارة مهامك بسهولة وكفاءة 🔥',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
