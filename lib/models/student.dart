class Student {
  String? userId; // رقم المستخدم (كـ نص)
  String? name; // اسم الطالب
  String? major; // تخصص الطالب
  String? email; // البريد الإلكتروني
  String? password; // الرقم السري

  // الوظائف لإضافة البيانات
  void addUserId(String id) {
    userId = id;
  }

  void addName(String studentName) {
    name = studentName;
  }

  void addMajor(String studentMajor) {
    major = studentMajor;
  }

  void addEmail(String studentEmail) {
    email = studentEmail;
  }

  void addPassword(String studentPassword) {
    password = studentPassword;
  }

  // وظيفة اختيارية لعرض معلومات الطالب
  void displayInfo() {
    print('رقم المستخدم: $userId');
    print('اسم الطالب: $name');
    print('التخصص: $major');
    print('البريد الإلكتروني: $email');
    print('الرقم السري: $password');
  }
}
