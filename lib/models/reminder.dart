class Reminder {
  // الخصائص
  String id;
  DateTime reminderTime;
  String message;

  // **المُنشئ**
  Reminder({
    required this.id,
    required this.reminderTime,
    required this.message,
  });

  // **الدوال الأساسية**
  void createReminder() {
    print("🔔 تم إنشاء التذكير: $message في $reminderTime");
  }

  void sendReminder() {
    print("📢 تذكير: $message - الموعد: $reminderTime");
  }

  void modifyReminder(String newMessage, DateTime newTime) {
    message = newMessage;
    reminderTime = newTime;
    print("✏ تم تعديل التذكير ليصبح: '$message' في $reminderTime");
  }

  void viewReminder() {
    print("📅 تفاصيل التذكير:");
    print("- 📝 الرسالة: $message");
    print("- ⏰ الموعد: $reminderTime");
  }

  void deleteReminder() {
    print("🗑 تم حذف التذكير: $message");
  }
}
