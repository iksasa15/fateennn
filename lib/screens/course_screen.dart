import 'package:flutter/material.dart';
import '../models/course.dart';
import 'package:intl/intl.dart';

class CourseScreen extends StatefulWidget {
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  List<Course> courses = [
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
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController creditController = TextEditingController();
  final TextEditingController classroomController = TextEditingController();
  DateTime? selectedTime;

  /// ✅ فتح نافذة لإضافة أو تعديل المقرر
  void _showCourseDialog({Course? course, int? index}) {
    bool isEditing = course != null;
    nameController.text = isEditing ? course.courseName : '';
    creditController.text = isEditing ? course.creditHours.toString() : '';
    classroomController.text = isEditing ? course.classroom : '';
    selectedTime = isEditing ? course.lectureTime : null;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'تعديل المقرر' : 'إضافة مقرر جديد'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "اسم المقرر")),
            TextField(
                controller: creditController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "عدد الساعات")),
            TextField(
                controller: classroomController,
                decoration: const InputDecoration(labelText: "قاعة المحاضرة")),
            const SizedBox(height: 10),
            ListTile(
              title: Text(selectedTime == null
                  ? "حدد وقت المحاضرة"
                  : "وقت المحاضرة: ${DateFormat.yMd().add_jm().format(selectedTime!)}"),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedTime ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(selectedTime ?? DateTime.now()),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      selectedTime = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                    });
                  }
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("إلغاء")),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  creditController.text.isNotEmpty &&
                  classroomController.text.isNotEmpty &&
                  selectedTime != null) {
                setState(() {
                  if (isEditing) {
                    courses[index!] = Course(
                      id: course!.id,
                      courseName: nameController.text,
                      creditHours: int.tryParse(creditController.text) ?? 0,
                      lectureTime: selectedTime!,
                      classroom: classroomController.text,
                    );
                  } else {
                    courses.add(Course(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      courseName: nameController.text,
                      creditHours: int.tryParse(creditController.text) ?? 0,
                      lectureTime: selectedTime!,
                      classroom: classroomController.text,
                    ));
                  }
                });
                Navigator.pop(context);
              }
            },
            child: const Text("حفظ"),
          ),
        ],
      ),
    );
  }

  void _deleteCourse(int index) {
    setState(() {
      courses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📚 إدارة المقررات'),
        backgroundColor: Colors.blueAccent,
      ),
      body: courses.isEmpty
          ? const Center(
              child: Text(
                'لا توجد مقررات متاحة 😢',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(course.courseName,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        '🕒 ${DateFormat.yMd().add_jm().format(course.lectureTime)} | 🏫 ${course.classroom}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _showCourseDialog(
                                course: course, index: index)),
                        IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteCourse(index)),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCourseDialog(),
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
