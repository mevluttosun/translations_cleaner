import 'dart:io';

import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';

/// Get list of all `*.json` files in the project
List<FileSystemEntity> translationFiles() {
  final path = Directory.current.path;

  final jsonFile = Glob("$path/assets/**??_??.json");
  return jsonFile.listSync(followLinks: false);
}
