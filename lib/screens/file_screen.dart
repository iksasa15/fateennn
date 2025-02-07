import 'package:flutter/material.dart';
import '../models/file.dart'; // استيراد كلاس File (تم التعديل)

class FileScreen extends StatefulWidget {
  const FileScreen({super.key});

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  List<File> files = [
    // ✅ تم تغيير FileModel إلى File
    File(id: '1', fileName: 'Lecture.pdf', fileSize: 2048, fileType: 'PDF'),
    File(id: '2', fileName: 'Notes.docx', fileSize: 1024, fileType: 'DOCX'),
    File(
        id: '3',
        fileName: 'Presentation.pptx',
        fileSize: 5120,
        fileType: 'PPTX'),
  ];

  // 🔹 عرض تفاصيل الملف
  void _viewFile(File file) {
    // ✅ تم تغيير FileModel إلى File
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("تفاصيل الملف"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("📂 الاسم: ${file.fileName}"),
              Text("📏 الحجم: ${file.fileSize} KB"),
              Text("📄 النوع: ${file.fileType}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("إغلاق"),
            ),
          ],
        );
      },
    );
  }

  // 🔹 تأكيد وحذف الملف
  void _confirmDeleteFile(File file) {
    // ✅ تم تغيير FileModel إلى File
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("حذف الملف"),
          content: Text("هل أنت متأكد من حذف الملف \"${file.fileName}\"؟"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("إلغاء"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  files.remove(file);
                  file.deleteFile(); // ✅ تنفيذ الحذف
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

  // 🔹 إضافة ملف جديد
  void _addFile() {
    setState(() {
      File newFile = File(
        // ✅ تم تغيير FileModel إلى File
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        fileName: 'NewFile.txt',
        fileSize: 500,
        fileType: 'TXT',
      );
      files.add(newFile);
      newFile.upload(); // ✅ محاكاة عملية الرفع
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الملفات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addFile, // ✅ إضافة ملف جديد
          ),
        ],
      ),
      body: files.isEmpty
          ? const Center(child: Text('لا توجد ملفات متاحة.'))
          : ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Icon(
                      file.fileType == 'PDF'
                          ? Icons.picture_as_pdf
                          : file.fileType == 'DOCX'
                              ? Icons.description
                              : file.fileType == 'PPTX'
                                  ? Icons.slideshow
                                  : file.fileType == 'TXT'
                                      ? Icons.text_snippet
                                      : Icons.insert_drive_file,
                      color: Colors.blue,
                    ),
                    title: Text(file.fileName),
                    subtitle: Text('الحجم: ${file.fileSize} KB'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.visibility, color: Colors.green),
                          onPressed: () {
                            _viewFile(file); // ✅ عرض الملف
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _confirmDeleteFile(file); // ✅ حذف الملف
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
