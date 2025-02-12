import 'dart:core';
import 'course.dart';

class Schedule {
  // قائمة الكورسات في الجدول الدراسي
  List<Course> courses;

  // **المُنشئ**
  Schedule({List<Course>? courses}) : courses = courses ?? [];

  // **الدوال الأساسية**

  /// عرض الجدول الأسبوعي
  void displayWeeklySchedule() {
    if (courses.isEmpty) {
      print("📅 لا يوجد كورسات مسجلة في الجدول.");
      return;
    }

    print("📆 الجدول الأسبوعي:");
    for (var course in courses) {
      print(
          "- 🏫 ${course.courseName} | ⏰ ${course.lectureTime} | 📍 ${course.classroom}");
    }
  }

  /// عرض تفاصيل جميع الكورسات في الجدول
  void displayCourseDetails() {
    if (courses.isEmpty) {
      print("📚 لا يوجد كورسات متاحة.");
      return;
    }

    print("📋 تفاصيل الكورسات:");
    for (var course in courses) {
      course.viewCourseDetails();
    }
  }

  /// جلب المحاضرة القادمة
  Course? getNextLecture() {
    if (courses.isEmpty) return null;

    // ترتيب الكورسات حسب وقت المحاضرة
    courses.sort((a, b) => a.lectureTime.compareTo(b.lectureTime));

    DateTime now = DateTime.now();
    for (var course in courses) {
      if (course.lectureTime.isAfter(now)) {
        print(
            "📌 المحاضرة القادمة: ${course.courseName} في ${course.lectureTime}");
        return course;
      }
    }

    print("⏳ لا توجد محاضرات متبقية لهذا اليوم.");
    return null;
  }

  /// إضافة كورس جديد إلى الجدول
  void addCourse(Course course) {
    courses.add(course);
    print("✅ تم إضافة الكورس '${course.courseName}' إلى الجدول.");
  }

  /// إزالة كورس من الجدول
  void removeCourse(String courseId) {
    courses.removeWhere((course) => course.id == courseId);
    print("🗑 تم إزالة الكورس من الجدول.");
  }
}
