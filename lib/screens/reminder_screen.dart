import 'package:flutter/material.dart';
import '../models/reminder.dart';

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  // قائمة تجريبية للتذكيرات
  List<Reminder> reminders = [
    Reminder(
      id: '1',
      reminderTime: DateTime.now().add(Duration(hours: 5)),
      message: '📚 مراجعة الفصل الأول من برمجة الموبايل',
    ),
    Reminder(
      id: '2',
      reminderTime: DateTime.now().add(Duration(days: 1, hours: 3)),
      message: '✍️ تسليم مشروع تحليل وتصميم النظم',
    ),
  ];

  /// دالة لإضافة تذكير جديد (كمثال)
  void _addReminder() {
    setState(() {
      reminders.add(
        Reminder(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          reminderTime: DateTime.now().add(Duration(days: 2, hours: 4)),
          message: '🔔 تذكير جديد',
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🔔 قائمة التذكيرات'),
        backgroundColor: Colors.orange,
      ),
      body: reminders.isEmpty
          ? Center(
              child: Text(
                'لا توجد تذكيرات حالياً 😴',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                final reminder = reminders[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(reminder.message,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('⏰ الموعد: ${reminder.reminderTime}'),
                    trailing: Icon(Icons.notifications_active),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('فتح ${reminder.message}')),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addReminder,
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
