import 'package:flutter/material.dart';
import 'home_screen.dart'; // ✅ استيراد صفحة الرئيسية
import 'signup_screen.dart'; // ✅ استيراد صفحة التسجيل
import 'package:fateen/models/student.dart'; // ✅ استيراد كلاس الطالب

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void loginUser() {
    // ✅ التحقق من البريد الإلكتروني وكلمة المرور
    final email = emailController.text;
    final password = passwordController.text;

    // ✅ البحث عن المستخدم في قائمة المستخدمين
    final matchedUser = usersList.firstWhere(
      (user) =>
          user.email == email && user.password == password, // مطابقة البيانات
      orElse: () => Student(), // إذا لم يتم العثور على المستخدم
    );

    if (matchedUser.email != null) {
      // ✅ إذا تم العثور على المستخدم، الانتقال إلى الصفحة الرئيسية مع استبدال الصفحة الحالية
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(userName: matchedUser.name ?? ''),
        ),
      );
    } else {
      // ✅ إذا لم يتم العثور على المستخدم، عرض رسالة خطأ
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('البريد الإلكتروني أو كلمة المرور غير صحيحة'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              // ✅ عنوان تسجيل الدخول
              const Center(
                child: Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'أهلاً بك في فطين!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 40),

              // ✅ حقل البريد الإلكتروني
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    border: InputBorder.none,
                    hintText: 'البريد الإلكتروني',
                    prefixIcon: Icon(Icons.email, color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ✅ حقل كلمة المرور
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    border: InputBorder.none,
                    hintText: 'كلمة المرور',
                    prefixIcon: Icon(Icons.lock, color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // ✅ زر تسجيل الدخول
              GestureDetector(
                onTap: loginUser,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ✅ نص تسجيل حساب جديد
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'ليس لديك حساب؟ ',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  GestureDetector(
                    onTap: () {
                      // ✅ الانتقال إلى صفحة التسجيل
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'أنشئ حساباً جديداً',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
