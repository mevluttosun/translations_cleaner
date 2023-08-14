import 'package:args/command_runner.dart';
import 'package:translations_manager/src/sort_terms.dart';

/// Command for sort translation terms in the translation files
class SortTranslation extends Command {
  SortTranslation();

  @override
  String get description => 'Sort translation terms in the translation files';

  @override
  String get name => 'sort-translations';

  @override
  void run() => sortTerms();
}
