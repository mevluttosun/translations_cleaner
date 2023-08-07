import 'package:args/command_runner.dart';
import 'package:translations_manager/src/add_terms.dart';

/// Command for add new terms to the translation files using google translate api
/// if save flag is true, the new terms will be saved to json files
class AddTranslation extends Command {
  AddTranslation() {
    argParser.addFlag('save',
        help: 'Save added keys into language files', abbr: 's');
  }

  @override
  String get description =>
      'Translate term into the language that is supported and add new terms to the translation files';

  @override
  String get name => 'add-translation';

  @override
  void run() => addTerms(argResults);
}
