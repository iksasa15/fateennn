class Reminder {
  final String id;
  final DateTime reminderTime;
  final String message;
  final String? relatedToId;

  Reminder({
    required this.id,
    required this.reminderTime,
    required this.message,
    this.relatedToId,
  });

  // ✅ إنشاء تذكير جديد
  static Reminder createReminder({
    required String message,
    required DateTime reminderTime,
    String? relatedToId,
  }) {
    return Reminder(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      reminderTime: reminderTime,
      message: message,
      relatedToId: relatedToId,
    );
  }

  // ✅ إرسال التذكير (محاكاة إشعار)
  void sendReminder() {
    print("🔔 إرسال التذكير: $message في ${reminderTime.toLocal()}");
  }

  // ✅ تعديل التذكير
  Reminder modifyReminder({DateTime? newTime, String? newMessage}) {
    return Reminder(
      id: id,
      reminderTime: newTime ?? reminderTime,
      message: newMessage ?? message,
      relatedToId: relatedToId,
    );
  }

  // ✅ عرض تذكير فردي
  void viewReminder() {
    print("🔔 تذكير:");
    print("📅 التاريخ والوقت: ${reminderTime.toLocal()}");
    print("📝 الرسالة: $message");
    if (relatedToId != null) {
      print("🔗 مرتبط بـ: $relatedToId");
    }
  }

  // ✅ عرض جميع التذكيرات (تمت إضافتها كدالة `static` لإصلاح الخطأ)
  static void viewReminders(List<Reminder> reminders) {
    if (reminders.isEmpty) {
      print("🚫 لا يوجد تذكيرات.");
      return;
    }
    for (var reminder in reminders) {
      reminder.viewReminder();
    }
  }

  // ✅ حذف التذكير
  void deleteReminder() {
    print("🗑️ تم حذف التذكير: $message");
  }
}
