import 'package:flutter/material.dart';
import '../models/task.dart';
import '../models/course.dart';
import 'package:intl/intl.dart'; // ✅ لإضافة تنسيق التاريخ

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [];

  void _addTask() {
    Course sampleCourse = Course(
      id: '1',
      courseName: 'برمجة تطبيقات الموبايل',
      creditHours: 3,
      lectureTime: DateTime.now().add(Duration(days: 1, hours: 2)),
      classroom: 'قاعة 101',
      grades: {},
      tasks: [],
      reminders: [],
    );

    setState(() {
      tasks.add(
        Task(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: 'مهمة جديدة',
          description: 'تفاصيل المهمة الجديدة',
          dueDate: DateTime.now().add(Duration(days: 7)),
          course: sampleCourse, // ✅ تمرير `course` هنا
          courseId: sampleCourse.id, // ✅ تمرير `courseId` أيضًا
          reminderTime: DateTime.now().add(Duration(days: 6)),
          status: "غير مكتملة",
          reminders: [], // ✅ إضافة قائمة `reminders` لتجنب الأخطاء
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('✅ قائمة المهام'),
        backgroundColor: Colors.green,
      ),
      body: tasks.isEmpty
          ? Center(
              child: Text(
                'لا توجد مهام متاحة 😴',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(
                      task.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '📅 تاريخ التسليم: ${DateFormat('yyyy-MM-dd').format(task.dueDate)}\n'
                      '📚 المادة: ${task.course.courseName}\n'
                      '🔹 الحالة: ${task.status}',
                    ),
                    trailing:
                        Icon(Icons.arrow_forward_ios), // ✅ تصحيح `trailing`
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('فتح ${task.name}')),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
