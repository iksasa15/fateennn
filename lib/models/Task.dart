import 'course.dart';
import 'reminder.dart';

class Task {
  String id;
  String name;
  String description;
  DateTime dueDate;
  Course course; // ✅ تعريف `course` كما هو مطلوب
  DateTime reminderTime;
  String status;
  List<Reminder> reminders;
  String courseId; // ✅ تعريف `courseId`

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.dueDate,
    required this.course, // ✅ تمرير `course` بشكل صحيح
    required this.reminderTime,
    required this.status,
    required this.reminders,
    required this.courseId,
  });

  // **دوال إدارة المهام**
  void createTask() {
    print("📝 تم إنشاء المهمة: $name");
  }

  void deleteTask() {
    print("🗑 تم حذف المهمة: $name");
  }

  void viewTaskDetails() {
    print("📄 تفاصيل المهمة:");
    print("- الاسم: $name");
    print("- الحالة: $status");
    print("- تاريخ التسليم: $dueDate");
    print("- المادة: ${course.courseName}"); // ✅ إظهار اسم المادة
  }
}
