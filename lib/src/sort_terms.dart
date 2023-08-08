import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:translations_manager/src/models/term.dart';
import 'package:translations_manager/src/save_google_api_key.dart';
import 'package:translations_manager/src/translation_files.dart';
import 'package:translations_manager/src/translation_terms.dart';

/// Sort translation terms in the translation files
Future<void> sortTerms() async {
  final files = translationFiles();
  for (var file in files) {
    final jsonFile = File(file.path);
    final originalContent = await jsonFile.readAsString();
    final json = jsonDecode(originalContent);
    final sortedJson = json.keys.toList()..sort();
    final sortedMap =
        Map.fromIterable(sortedJson, key: (k) => k, value: (k) => json[k]);
    final encoder = JsonEncoder.withIndent('  '); // Two spaces indentation
    final sortedContent = encoder.convert(sortedMap);
    await jsonFile.writeAsString(sortedContent);
    print('Sorted ${file.path.split('/').last}');
  }
}
