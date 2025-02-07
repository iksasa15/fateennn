import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/reminder.dart';

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  List<Reminder> reminders = [
    Reminder(
      id: "1",
      reminderTime: DateTime.now().add(const Duration(hours: 2)),
      message: "لا تنسَ حضور محاضرة البرمجة في الساعة 2 مساءً!",
      relatedToId: "CS101",
    ),
    Reminder(
      id: "2",
      reminderTime: DateTime.now().add(const Duration(days: 1, hours: 3)),
      message: "يجب تسليم مشروع فلاتر غداً الساعة 5 مساءً!",
      relatedToId: "Task_001",
    ),
  ];

  // 🔹 إضافة تذكير جديد
  void _showAddReminderDialog() {
    TextEditingController messageController = TextEditingController();
    DateTime selectedDateTime = DateTime.now().add(const Duration(days: 1));
    String relatedToId = "CS101"; // افتراضيًا لكورس

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("إضافة تذكير جديد"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: messageController,
                decoration: const InputDecoration(labelText: "رسالة التذكير"),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: Text(
                    "📅 التاريخ والوقت: ${DateFormat('yyyy/MM/dd hh:mm a').format(selectedDateTime)}"),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDateTime,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    TimeOfDay? timePicked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                    );
                    if (timePicked != null) {
                      setState(() {
                        selectedDateTime = DateTime(
                          picked.year,
                          picked.month,
                          picked.day,
                          timePicked.hour,
                          timePicked.minute,
                        );
                      });
                    }
                  }
                },
              ),
              DropdownButtonFormField<String>(
                value: relatedToId,
                items: ["CS101", "Task_001"].map((id) {
                  return DropdownMenuItem(
                      value: id, child: Text("مرتبط بـ: $id"));
                }).toList(),
                onChanged: (value) {
                  relatedToId = value!;
                },
                decoration:
                    const InputDecoration(labelText: "اختر الكورس أو المهمة"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("إلغاء"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  reminders.add(Reminder.createReminder(
                    message: messageController.text,
                    reminderTime: selectedDateTime,
                    relatedToId: relatedToId,
                  ));
                });
                Navigator.pop(context);
              },
              child: const Text("إضافة"),
            ),
          ],
        );
      },
    );
  }

  // 🔹 حذف التذكير مع التأكيد
  void _confirmDeleteReminder(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("حذف التذكير"),
          content: const Text("هل أنت متأكد من حذف هذا التذكير؟"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("إلغاء"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  reminders.removeWhere((reminder) => reminder.id == id);
                });
                Navigator.pop(context);
              },
              child: const Text("حذف"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // ✅ استدعاء `viewReminders()` لطباعة جميع التذكيرات عند تشغيل التطبيق
    Reminder.viewReminders(reminders);

    return Scaffold(
      appBar: AppBar(
        title: const Text("📅 التذكيرات"),
        backgroundColor: Colors.blueAccent,
      ),
      body: reminders.isEmpty
          ? const Center(
              child: Text(
                "لا توجد تذكيرات بعد!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                final reminder = reminders[index];
                return Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      reminder.relatedToId?.startsWith("CS") ?? false
                          ? Icons.school
                          : Icons.assignment,
                      color: Colors.blue,
                    ),
                    title: Text(reminder.message,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        "🕒 ${DateFormat('yyyy/MM/dd hh:mm a').format(reminder.reminderTime)}\n🔗 مرتبط بـ: ${reminder.relatedToId ?? "غير محدد"}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _confirmDeleteReminder(reminder.id),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddReminderDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
