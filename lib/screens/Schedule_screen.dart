import 'package:flutter/material.dart';
import '../models/course.dart';
import '../models/schedule.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  // إنشاء جدول دراسي مع بعض الكورسات التجريبية
  Schedule schedule = Schedule(
    courses: [
      Course(
        id: '1',
        courseName: 'برمجة تطبيقات الموبايل',
        creditHours: 3,
        lectureTime: DateTime.now().add(Duration(days: 1, hours: 2)),
        classroom: 'قاعة 101',
      ),
      Course(
        id: '2',
        courseName: 'تحليل وتصميم النظم',
        creditHours: 3,
        lectureTime: DateTime.now().add(Duration(days: 2, hours: 3)),
        classroom: 'قاعة 202',
      ),
    ],
  );

  /// دالة لإضافة كورس جديد إلى الجدول (كمثال)
  void _addCourse() {
    setState(() {
      schedule.addCourse(
        Course(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          courseName: 'كورس جديد',
          creditHours: 3,
          lectureTime: DateTime.now().add(Duration(days: 3, hours: 4)),
          classroom: 'قاعة 303',
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('📆 الجدول الدراسي'),
        backgroundColor: Colors.purple,
      ),
      body: schedule.courses.isEmpty
          ? Center(
              child: Text(
                'لا توجد كورسات في الجدول 😴',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: schedule.courses.length,
              itemBuilder: (context, index) {
                final course = schedule.courses[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(course.courseName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        '🕒 ${course.lectureTime} | 🏫 ${course.classroom}'),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('فتح ${course.courseName}')),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCourse,
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
