import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../models/file.dart'; // تأكد من استيراد `File` بشكل صحيح

class FileScreen extends StatefulWidget {
  const FileScreen({super.key});
  @override
  _FileScreenState createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  // قائمة الملفات
  List<File> uploadedFiles = []; // استبدل AppFile بـ File

  /// دالة لاختيار ملف
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;

      setState(() {
        uploadedFiles.add(
          File(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            fileName: file.name,
            fileSize: file.size,
            fileType: file.extension ?? 'Unknown',
          ),
        );
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ تم رفع الملف: ${file.name}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📂 إدارة الملفات')),
      body: uploadedFiles.isEmpty
          ? const Center(child: Text('لا توجد ملفات 📁'))
          : ListView.builder(
              itemCount: uploadedFiles.length,
              itemBuilder: (context, index) {
                final file = uploadedFiles[index];
                return ListTile(
                  title: Text(file.fileName),
                  subtitle: Text('📏 الحجم: ${file.fileSize} KB'),
                  trailing: const Icon(Icons.file_present),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickFile,
        child: const Icon(Icons.upload_file),
      ),
    );
  }
}
