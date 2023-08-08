import 'dart:convert';
import 'dart:io';

import 'package:translations_manager/src/models/term.dart';
import 'package:translations_manager/src/translation_files.dart';

/// Iterate through all files ending in `*.json` and extract all the translation
/// terms being used.
///
Set<Term> getTranslationTerms() {
  final translationFileList = translationFiles();

  final jsonTerms = <Term>{};

  try {
    for (final file in translationFileList) {
      final content = File(file.path).readAsStringSync();
      final map = jsonDecode(content) as Map<String, dynamic>;
      // print('map: $map');
      for (final entry in map.entries) {
        // print('entry: $entry');
        jsonTerms.add(Term(
            key: entry.key,
            value: entry.value.toString(),
            filename: file.path.split('/').last));
      }
    }
    return jsonTerms;
  } catch (e) {
    return jsonTerms;
  }
}
