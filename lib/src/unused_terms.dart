import 'dart:io';

import 'package:translations_manager/src/models/term.dart';
import 'package:translations_manager/src/project_files.dart';
import 'package:translations_manager/src/translation_terms.dart';

/// Searches through all `*.json` files to check which translation terms
/// have not been used.
Set<Term> findUnusedTerms() {
  print('FETCHING ALL THE TRANSLATION TERMS 🌏');
  final terms = getTranslationTerms();
  print('FETCHING ALL THE DART FILES TO LOOK THROUGH 🏗');
  final dartFiles = getDartFiles();
  print('LOOKING THROUGH FILES TO FIND UNUSED TERMS 👀');
  final unusedTerms = Set<Term>.from(terms);

  for (final file in dartFiles) {
    final content = File(file.path).readAsStringSync();
    for (final json in terms) {
      if (content.contains(json.key)) {
        unusedTerms.remove(json);
      }
    }
  }
  return unusedTerms;
}

bool isTermUsed(String term) {
  print('FETCHING ALL THE TRANSLATION TERMS 🌏');
  final terms = getTranslationTerms();
  print('FETCHING ALL THE DART FILES TO LOOK THROUGH 🏗');
  final dartFiles = getDartFiles();
  print('LOOKING THROUGH FILES TO FIND TERM 👀');

  for (final file in dartFiles) {
    final content = File(file.path).readAsStringSync();
    for (final json in terms) {
      if (content.contains(json.key)) {
        return true;
      }
    }
  }
  return false;
}
