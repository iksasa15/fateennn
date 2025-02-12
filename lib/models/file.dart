class File {
  // الخصائص
  String id;
  String fileName;
  int fileSize; // الحجم بالكيلوبايت (KB)
  String fileType; // مثل "PDF" أو "DOCX"

  // **المُنشئ**
  File({
    required this.id,
    required this.fileName,
    required this.fileSize,
    required this.fileType,
  });

  // **دالة رفع الملف**
  void upload() {
    print("📂 تم رفع الملف: $fileName ($fileType) بحجم $fileSize KB");
  }

  // **دالة عرض تفاصيل الملف**
  void view() {
    print("📄 تفاصيل الملف:");
    print("- 📌 الاسم: $fileName");
    print("- 💾 الحجم: $fileSize KB");
    print("- 📑 النوع: $fileType");
  }

  // **دالة حذف الملف**
  void deleteFile() {
    print("🗑 تم حذف الملف: $fileName");
  }
}
