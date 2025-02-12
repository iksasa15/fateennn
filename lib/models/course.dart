import 'task.dart';
import 'reminder.dart';

class Course {
  // الخصائص
  String id;
  String courseName;
  int creditHours;
  DateTime lectureTime;
  String classroom;
  Map<String, double> grades;
  List<Task> tasks;
  List<Reminder> reminders;

  // **المُنشئ**
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

  // **الدوال الأساسية**
  void createCourse() {
    print("📚 تم إنشاء الكورس: $courseName");
  }

  void deleteCourse() {
    print("🗑 تم حذف الكورس: $courseName");
  }

  void modifyCourseDetails(String name, int hours, DateTime time, String room) {
    courseName = name;
    creditHours = hours;
    lectureTime = time;
    classroom = room;
    print("✏ تم تعديل تفاصيل الكورس: $courseName");
  }

  void viewCourseDetails() {
    print("🔹 تفاصيل الكورس:");
    print("📌 الاسم: $courseName");
    print("📚 عدد الساعات: $creditHours");
    print("⏰ وقت المحاضرة: $lectureTime");
    print("🏫 القاعة: $classroom");
  }

  void createTask(Task task) {
    tasks.add(task);
    print("✅ تمت إضافة المهمة '${task.name}' إلى الكورس '$courseName'");
  }

  void viewTasks() {
    print("📌 المهام الخاصة بالكورس '$courseName':");
    for (var task in tasks) {
      print("- ${task.name} (🔹 الحالة: ${task.status})");
    }
  }

  void modifyTask(String taskId, String newName) {
    for (var task in tasks) {
      if (task.id == taskId) {
        task.name = newName;
        print("✏ تم تعديل اسم المهمة إلى '$newName'");
        return;
      }
    }
    print("⚠ لم يتم العثور على المهمة!");
  }

  void createGrade(String assignment, double grade) {
    grades[assignment] = grade;
    print(
        "📊 تمت إضافة درجة '$grade' لـ '$assignment' في الكورس '$courseName'");
  }

  void modifyGrade(String assignment, double newGrade) {
    if (grades.containsKey(assignment)) {
      grades[assignment] = newGrade;
      print("✏ تم تعديل درجة '$assignment' إلى '$newGrade'");
    } else {
      print("⚠ لم يتم العثور على التقييم '$assignment'");
    }
  }

  void viewGrades() {
    print("📊 درجات الكورس '$courseName':");
    grades.forEach((assignment, grade) {
      print("- $assignment: $grade");
    });
  }

  void createLectureReminder(Reminder reminder) {
    reminders.add(reminder);
    print("📅 تم تعيين تذكير لمحاضرة '$courseName'");
  }

  void modifyReminder(String reminderId, String newMessage) {
    for (var reminder in reminders) {
      if (reminder.id == reminderId) {
        reminder.message = newMessage;
        print("🔔 تم تعديل التذكير إلى: '$newMessage'");
        return;
      }
    }
    print("⚠ لم يتم العثور على التذكير!");
  }

  void viewReminders() {
    print("📝 التذكيرات الخاصة بالكورس '$courseName':");
    for (var reminder in reminders) {
      print("- ${reminder.message} (📆 في: ${reminder.reminderTime})");
    }
  }

  void deleteReminder(String reminderId) {
    reminders.removeWhere((reminder) => reminder.id == reminderId);
    print("🗑 تم حذف التذكير بنجاح!");
  }
}
