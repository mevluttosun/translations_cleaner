import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';
import 'package:translations_manager/src/translation_files.dart';

/// Compare each translation files to find difference
Future<void> compareTranslation(ArgResults? argResults) async {
  final files = translationFiles();
  for (var file in files) {
    Map<String, dynamic> fileJson = {};
    try {
      final fileString = await File(file.path).readAsString();
      fileJson = jsonDecode(fileString);
    } catch (e) {
      File(file.path)
          .writeAsString(JsonEncoder.withIndent(' ' * 4).convert({}));
    }
    for (var term in fileJson.keys) {
      for (var file in files) {
        Map<String, dynamic> fileJson = {};
        try {
          final fileString = await File(file.path).readAsString();
          fileJson = jsonDecode(fileString);
        } catch (e) {
          File(file.path)
              .writeAsString(JsonEncoder.withIndent(' ' * 4).convert({}));
        }
        final result = fileJson.keys.where((element) => element == term);
        if (result.isEmpty) {
          print("⭕️ Term '$term' is missing in ${file.path.split('/').last}");
        }
      }
    }
  }
}
