import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/course.dart';
import '../models/task.dart';
import '../models/reminder.dart';

class CourseScreen extends StatefulWidget {
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  // تهيئة الكورس مباشرةً
  Course course = Course(
    id: 'CS101',
    courseName: 'Introduction to Computer Science',
    creditHours: 3,
    lectureTime: DateTime(2024, 6, 10, 9, 0),
    classroom: 'Room A1',
  );

  @override
  void initState() {
    super.initState();

    // إضافة بيانات تجريبية
    course.createGrade('Ali', 85.5);
    course.createGrade('Sara', 92.0);
    course.createTask(Task(
      id: 'T1',
      name: 'Assignment 1',
      description: 'Solve the exercises',
      dueDate: DateTime(2024, 6, 15),
    ));
    course.createLectureReminder(Reminder(
      id: 'R1',
      title: 'Exam Reminder',
      reminderTime: DateTime(2024, 6, 20, 14, 0),
      message: 'Midterm exam is coming!',
    ));
  }

  // 🔹 إضافة درجة جديدة
  void _showAddGradeDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController gradeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("إضافة درجة جديدة"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "اسم الطالب"),
              ),
              TextField(
                controller: gradeController,
                decoration: InputDecoration(labelText: "الدرجة"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("إلغاء"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  String name = nameController.text;
                  double grade = double.tryParse(gradeController.text) ?? 0.0;
                  if (name.isNotEmpty) {
                    course.createGrade(name, grade);
                  }
                });
                Navigator.pop(context);
              },
              child: Text("إضافة"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.courseName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📌 معلومات الكورس
            _buildSectionTitle("معلومات الكورس"),
            _buildDetail("ID", course.id),
            _buildDetail("عدد الساعات", course.creditHours.toString()),
            _buildDetail("وقت المحاضرة",
                DateFormat('yyyy-MM-dd HH:mm').format(course.lectureTime)),
            _buildDetail("القاعة", course.classroom),
            SizedBox(height: 16),

            // 📌 الدرجات
            _buildSectionTitle("درجات الطلاب"),
            ...course.grades.entries.map(
                (entry) => _buildDetail(entry.key, entry.value.toString())),
            SizedBox(height: 16),

            // 📌 قائمة المهام
            _buildSectionTitle("المهام"),
            _buildListView(
                course.tasks,
                (task) => ListTile(
                      title: Text(task.name),
                      subtitle: Text(task.description),
                      trailing:
                          Text(DateFormat('yyyy-MM-dd').format(task.dueDate)),
                      onTap: () => _modifyTaskDialog(task),
                    )),
            SizedBox(height: 16),

            // 📌 التذكيرات
            _buildSectionTitle("التذكيرات"),
            _buildListView(
                course.reminders,
                (reminder) => ListTile(
                      title: Text(reminder.title),
                      subtitle: Text(reminder.message),
                      trailing: Text(DateFormat('yyyy-MM-dd HH:mm')
                          .format(reminder.reminderTime)),
                      onTap: () => _modifyReminderDialog(reminder),
                    )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddGradeDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  // 🔹 تعديل مهمة
  void _modifyTaskDialog(Task task) {
    TextEditingController nameController =
        TextEditingController(text: task.name);
    TextEditingController descController =
        TextEditingController(text: task.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("تعديل المهمة"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "اسم المهمة")),
              TextField(
                  controller: descController,
                  decoration: InputDecoration(labelText: "الوصف")),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("إلغاء")),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  course.modifyTask(task.id, nameController.text,
                      descController.text, task.dueDate);
                });
                Navigator.pop(context);
              },
              child: Text("تعديل"),
            ),
          ],
        );
      },
    );
  }

  // 🔹 تعديل تذكير
  void _modifyReminderDialog(Reminder reminder) {
    TextEditingController titleController =
        TextEditingController(text: reminder.title);
    TextEditingController messageController =
        TextEditingController(text: reminder.message);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("تعديل التذكير"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: "العنوان")),
              TextField(
                  controller: messageController,
                  decoration: InputDecoration(labelText: "الرسالة")),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("إلغاء")),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  course.modifyReminder(reminder.id, titleController.text,
                      reminder.reminderTime, messageController.text);
                });
                Navigator.pop(context);
              },
              child: Text("تعديل"),
            ),
          ],
        );
      },
    );
  }

  // 🔹 عنصر عنوان القسم
  Widget _buildSectionTitle(String title) {
    return Text(title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  // 🔹 عنصر تفصيلي
  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text("$label: $value"),
    );
  }

  // 🔹 قائمة عرض ديناميكية
  Widget _buildListView<T>(List<T> items, Widget Function(T) itemBuilder) {
    return Column(children: items.map(itemBuilder).toList());
  }
}
