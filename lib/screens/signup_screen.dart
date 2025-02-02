import 'package:flutter/material.dart';
import 'package:fateen/models/student.dart'; // استيراد كلاس الطالب
import 'login_screen.dart'; // استيراد صفحة تسجيل الدخول

// قائمة لتخزين المستخدمين المسجلين
List<Student> usersList = [];

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final Student student = Student(); // إنشاء كائن من كلاس Student
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController majorController = TextEditingController();

  void registerUser() {
    // التحقق من إدخال جميع الحقول
    if (userIdController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        majorController.text.isNotEmpty) {
      // تخزين بيانات الطالب في الكائن
      student.addUserId(userIdController.text);
      student.addName(nameController.text);
      student.addEmail(emailController.text);
      student.addPassword(passwordController.text);
      student.addMajor(majorController.text);

      // إضافة الطالب إلى قائمة المستخدمين
      usersList.add(student);

      // إظهار رسالة نجاح
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إنشاء الحساب بنجاح!'),
          backgroundColor: Colors.green,
        ),
      );

      // الانتقال إلى صفحة تسجيل الدخول
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      // إظهار رسالة خطأ إذا كانت الحقول فارغة
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى ملء جميع الحقول'),
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
              // عنوان إنشاء حساب جديد
              const Center(
                child: Text(
                  'إنشاء حساب جديد',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'قم بإنشاء حساب للانضمام إلى فطين!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 40),

              // حقل رقم المستخدم
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: userIdController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    border: InputBorder.none,
                    hintText: 'رقم المستخدم',
                    prefixIcon: Icon(Icons.numbers, color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // حقل الاسم
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    border: InputBorder.none,
                    hintText: 'الاسم الكامل',
                    prefixIcon: Icon(Icons.person, color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // حقل التخصص
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: majorController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    border: InputBorder.none,
                    hintText: 'التخصص',
                    prefixIcon: Icon(Icons.school, color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // حقل البريد الإلكتروني
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
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

              // حقل كلمة المرور
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
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

              // زر إنشاء الحساب
              GestureDetector(
                onTap: registerUser,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.4),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'إنشاء حساب',
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

              // نص العودة إلى تسجيل الدخول
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'لديك حساب بالفعل؟ ',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'تسجيل الدخول',
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
