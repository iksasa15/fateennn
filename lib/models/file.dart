class File {
  final String id;
  final String fileName;
  final int fileSize;
  final String fileType;

  File({
    required this.id,
    required this.fileName,
    required this.fileSize,
    required this.fileType,
  });

  // ✅ تحميل الملف (محاكاة عملية الرفع)
  void upload() {
    print("📤 يتم تحميل الملف: $fileName (${fileSize}KB) بنوع $fileType...");
  }

  // ✅ عرض تفاصيل الملف
  void view() {
    print("👀 عرض الملف:");
    print("📂 الاسم: $fileName");
    print("📏 الحجم: ${fileSize}KB");
    print("📄 النوع: $fileType");
  }

  // ✅ حذف الملف
  void deleteFile() {
    print("🗑️ تم حذف الملف: $fileName");
  }
}
