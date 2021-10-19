import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static String formatBytes(bytes, decimals) {
    if (bytes == 0) return '0.0 KB';
    var k = 1024,
        dm = decimals <= 0 ? 0 : decimals,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = (log(bytes) / log(k)).floor();
    return (((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i]);
  }

  static Future<List<Directory>> getStorageList() async {
    List<Directory> paths = [];

    if (Platform.isAndroid) {
      paths.addAll((await getExternalStorageDirectories())!);
    }
    if (Platform.isIOS) {
      print(
          'getApplicationDocumentsDirectory: ${await getApplicationDocumentsDirectory()}');
      paths.add(await getApplicationDocumentsDirectory());

      // print(
      //     'getApplicationSupportDirectory: ${await getApplicationSupportDirectory()}');
      // paths.add(await getApplicationSupportDirectory());
    }

    List<Directory> filteredPaths = <Directory>[];
    for (Directory dir in paths) {
      print('dir $dir');
      filteredPaths.add(removeDataDirectory(dir.path));
    }
    return filteredPaths;
  }

  static Directory removeDataDirectory(String path) {
    if (Platform.isAndroid)
      return Directory(path.split('Android')[0]);
    else
      return Directory(path.split('Application')[0]);
  }

  /// Get all Files on the Device
  static Future<List<FileSystemEntity>> getAllFiles(
      {bool showHidden = false}) async {
    List<Directory> storages = await getStorageList();
    List<FileSystemEntity> files = <FileSystemEntity>[];
    for (Directory dir in storages) {
      List<FileSystemEntity> allFilesInPath = [];
      // This is important to catch storage errors
      try {
        allFilesInPath =
            await getAllFilesInPath(dir.path, showHidden: showHidden);
      } catch (e) {
        allFilesInPath = [];
        print(e);
      }
      files.addAll(allFilesInPath);
    }
    return files;
  }

  static Future<List<FileSystemEntity>> getAllFilesInPath(String path,
      {bool showHidden = false}) async {
    List<FileSystemEntity> files = <FileSystemEntity>[];
    Directory d = Directory(path);
    List<FileSystemEntity> l = d.listSync();
    for (FileSystemEntity file in l) {
      if (FileSystemEntity.isFileSync(file.path)) {
        if (!showHidden) {
          if (!basename(file.path).startsWith('.')) {
            files.add(file);
          }
        } else {
          files.add(file);
        }
      } else {
        if (!file.path.contains('/storage/emulated/0/Android')) {
//          print(file.path);
          if (!showHidden) {
            if (!basename(file.path).startsWith('.')) {
              files.addAll(
                  await getAllFilesInPath(file.path, showHidden: showHidden));
            }
          } else {
            files.addAll(
                await getAllFilesInPath(file.path, showHidden: showHidden));
          }
        }
      }
    }
//    print(files);
    return files;
  }

  static Future<List<FileSystemEntity>> getRecentFiles(
      {bool showHidden = false}) async {
    List<FileSystemEntity> files = await getAllFiles(showHidden: showHidden);
    files.sort((a, b) => File(a.path)
        .lastAccessedSync()
        .compareTo(File(b.path).lastAccessedSync()));
    return files.reversed.toList();
  }
}
