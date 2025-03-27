import 'dart:io';

class FileManager {
  static Future<Directory> getAppStorageDirectory() async {
    Directory? appDir;

    if (Platform.isAndroid) {
      appDir = Directory("/storage/emulated/0/Dynamic Pro"); // اسم التطبيق
    } else if (Platform.isIOS) {
      appDir = Directory("${(Directory.systemTemp).path}/Dynamic Pro");
    }

    if (appDir != null && !(await appDir.exists())) {
      await appDir.create(recursive: true);
    }

    return appDir!;
  }
}