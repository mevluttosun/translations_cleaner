import 'dart:io';

import 'package:translations_manager/src/models/term.dart';
import 'package:translations_manager/src/project_files.dart';
import 'package:translations_manager/src/translation_terms.dart';

/// Searches through all `*.dart` files to check which translation terms
/// have not been added to translation files
Set<Term> findMissingTerms() {
  print('FETCHING ALL THE TRANSLATION TERMS 🌏');
  final addedTerms = getTranslationTerms();
  print('FETCHING ALL THE DART FILES TO LOOK THROUGH 🏗');
  final dartFiles = getDartFiles();
  print('LOOKING THROUGH FILES TO FIND MISSING TERMS 👀');
  final missingTerms = Set<Term>();

  // Regular expression to match strings with .tr at the end
  final regExp = RegExp(r'''"([^"]+)"\s*\.tr\(\)|'([^']+)'\.tr\(\)''');

  for (final dartFile in dartFiles) {
    final content = File(dartFile.path).readAsStringSync();
    final matches = regExp.allMatches(content);

    for (final match in matches) {
      final termFromDoubleQuote = match.group(1)?.replaceAll('.tr', '');
      final termFromSingleQuote = match.group(2)?.replaceAll('.tr', '');
      final term = termFromDoubleQuote ?? termFromSingleQuote;
      if (term != null) {
        final termFound = addedTerms.firstWhere(
          (element) => element.key == term,
          orElse: () => Term(
              key: term, filename: dartFile.path.split('/').last, value: ''),
        );
        if (termFound.value.isEmpty) {
          missingTerms.add(termFound);
        }
      }
    }
  }

  return missingTerms;
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
