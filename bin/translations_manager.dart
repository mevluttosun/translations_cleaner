import 'package:args/command_runner.dart';

import 'commands/add_translation.dart';
import 'commands/clean_translation.dart';
import 'commands/compare_translation.dart';
import 'commands/configure_translate_api.dart';
import 'commands/list_unused_translations.dart';

void main(List<String> arguments) {
  CommandRunner(
      'dart run translations_manager',
      'Dart package to clean unused '
          'translations from the json files')
    ..addCommand(ListUnusedTranslations())
    ..addCommand(CleanTranslation())
    ..addCommand(CompareTranslation())
    ..addCommand(ConfigureTranslateApi())
    ..addCommand(AddTranslation())
    ..run(arguments);
}
