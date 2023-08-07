import 'package:args/command_runner.dart';
import 'package:translations_manager/src/compare_translate_files.dart';

/// Command for compare translation files for missing terms
class CompareTranslation extends Command {
  CompareTranslation() {
    // argParser.addFlag('delete',
    //     help: 'Delete unused keys from the translation files', abbr: 'd');
  }

  @override
  String get description => 'Compare the translation files with each other and '
      'find the missing terms';

  @override
  String get name => 'compare-translation';

  @override
  void run() => compareTranslation(argResults);
}
