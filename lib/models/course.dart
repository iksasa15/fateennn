import 'task.dart';
import 'reminder.dart';

class Course {
  // الخصائص الأساسية للكورس
  final String id;
  final String courseName;
  final int creditHours;
  final DateTime lectureTime;
  final String classroom;

  // قائمة الطلاب المسجلين في الكورس (اسم الطالب → الدرجة)
  final Map<String, double> grades;

  // قائمة المهام المرتبطة بالكورس
  final List<Task> tasks;

  // قائمة التذكيرات المرتبطة بالكورس
  final List<Reminder> reminders;

  // المُنشئ (Constructor)
  Course({
    required this.id,
    required this.courseName,
    required this.creditHours,
    required this.lectureTime,
    required this.classroom,
    Map<String, double>? grades,
    List<Task>? tasks,
    List<Reminder>? reminders,
  })  : grades = grades ?? {},
        tasks = tasks ?? [],
        reminders = reminders ?? [];

  // 🟢 إنشاء كورس جديد
  void createCourse() {
    print("تم إنشاء الكورس: $courseName");
  }

  // 🟢 حذف الكورس
  void deleteCourse() {
    print("تم حذف الكورس: $courseName");
  }

  // 🟢 تعديل تفاصيل الكورس
  void modifyCourseDetails(
      String newName, int newCreditHours, String newClassroom) {
    print("تم تعديل بيانات الكورس");
    // لا يمكن تعديل القيم لأن الخصائص `final`
  }

  // 🟢 عرض تفاصيل الكورس
  void viewCourseDetails() {
    print("""
    📘 تفاصيل الكورس:
    - ID: $id
    - الاسم: $courseName
    - عدد الساعات: $creditHours
    - وقت المحاضرة: $lectureTime
    - القاعة: $classroom
    """);
  }

  // 🟢 جلب جميع الكورسات (ممكن يكون جزء من كود آخر)
  void getCurrentCourses() {
    print("عرض جميع الكورسات...");
  }

  // 🟢 إنشاء مهمة جديدة
  void createTask(Task task) {
    tasks.add(task);
    print("تمت إضافة المهمة: ${task.name}");
  }

  // 🟢 عرض مهمة محددة
  void viewTask(String taskId) {
    Task? task = tasks.firstWhere((t) => t.id == taskId,
        orElse: () =>
            Task(id: '', name: '', description: '', dueDate: DateTime.now()));
    if (task.id.isNotEmpty) {
      print("📌 المهمة: ${task.name} - ${task.description}");
    } else {
      print("❌ المهمة غير موجودة.");
    }
  }

  // 🟢 تعديل مهمة
  void modifyTask(String taskId, String newName, String newDescription,
      DateTime newDueDate) {
    for (var task in tasks) {
      if (task.id == taskId) {
        task.name = newName;
        task.description = newDescription;
        task.dueDate = newDueDate;
        print("تم تعديل المهمة: $newName");
        return;
      }
    }
    print("❌ المهمة غير موجودة.");
  }

  // 🟢 إنشاء درجة لطالب
  void createGrade(String studentName, double grade) {
    grades[studentName] = grade;
    print("تمت إضافة درجة للطالب: $studentName - $grade");
  }

  // 🟢 تعديل درجة طالب
  void modifyGrade(String studentName, double newGrade) {
    if (grades.containsKey(studentName)) {
      grades[studentName] = newGrade;
      print("تم تعديل درجة الطالب: $studentName - $newGrade");
    } else {
      print("❌ الطالب غير موجود.");
    }
  }

  // 🟢 عرض جميع الدرجات
  void viewGrades() {
    print("📊 درجات الطلاب:");
    grades.forEach((name, grade) {
      print("$name: $grade");
    });
  }

  // 🟢 إنشاء تذكير جديد للمحاضرة
  void createLectureReminder(Reminder reminder) {
    reminders.add(reminder);
    print("📅 تمت إضافة تذكير للمحاضرة: ${reminder.title}");
  }

  // 🟢 تعديل تذكير
  void modifyReminder(
      String reminderId, String newTitle, DateTime newTime, String newMessage) {
    for (var reminder in reminders) {
      if (reminder.id == reminderId) {
        reminder.title = newTitle;
        reminder.reminderTime = newTime;
        reminder.message = newMessage;
        print("تم تعديل التذكير: $newTitle");
        return;
      }
    }
    print("❌ التذكير غير موجود.");
  }

  // 🟢 عرض جميع التذكيرات
  void viewReminders() {
    print("🔔 جميع التذكيرات:");
    reminders.forEach((reminder) {
      print("${reminder.title} - ${reminder.reminderTime}");
    });
  }

  // 🟢 حذف تذكير
  void deleteReminder(String reminderId) {
    reminders.removeWhere((reminder) => reminder.id == reminderId);
    print("🗑️ تم حذف التذكير.");
  }
}
