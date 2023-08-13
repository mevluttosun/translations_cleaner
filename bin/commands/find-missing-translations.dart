import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:translations_manager/src/export_unused_terms.dart';
import 'package:translations_manager/src/missing_terms.dart';

/// Command for finding missing translation terms used in dart files
class FindMissingTranslations extends Command {
  FindMissingTranslations() {
    argParser.addOption('output-path',
        abbr: 'o',
        help: 'Path for saving exported '
            'file, defaults to root path of the folder');
    argParser.addFlag('export',
        help: 'Save unused keys as a .txt file'
            'in the path provided',
        abbr: 'e');
  }

  @override
  String get description =>
      'Search all the dart files and find missing translations'
      'print/save a list of unused translations';

  @override
  String get name => 'find-missing-translations';

  @override
  void run() async {
    final bool exportTermsFlag = argResults?['export'];
    final String? outputPath = argResults?['output-path'];
    final missingTerms = findMissingTerms();
    if (exportTermsFlag) {
      exportTerms(missingTerms, outputPath, filename: 'missing-translations');
    } else {
      for (var term in missingTerms) {
        print("⭕️ ${term.filename} => '${term.key}'");
      }
      print('Total ${missingTerms.length} unused keys ✅');
    }
  }
}
