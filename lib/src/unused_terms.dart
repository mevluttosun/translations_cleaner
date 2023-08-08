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
    for (final term in terms) {
      final escapedTerm = escapeSpecialCharacters(term.key);
      if (content.contains(escapedTerm)) {
        unusedTerms.remove(term);
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
    for (final term in terms) {
      final escapedTerm = escapeSpecialCharacters(term.key);
      if (content.contains(escapedTerm)) {
        return true;
      }
    }
  }
  return false;
}

String escapeSpecialCharacters(String input) {
  return input.replaceAllMapped(RegExp(r'[\n\r\t\b\f]'), (match) {
    switch (match[0]) {
      case '\n':
        return '\\n';
      case '\r':
        return '\\r';
      case '\t':
        return '\\t';
      case '\b':
        return '\\b';
      case '\f':
        return '\\f';
      default:
        return match[0]!;
    }
  });
}
