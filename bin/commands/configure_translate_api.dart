import 'package:args/command_runner.dart';
import 'package:translations_manager/src/save_google_api_key.dart';

/// Command for cleaning the translation files from all the unused translations
class ConfigureTranslateApi extends Command {
  ConfigureTranslateApi();

  @override
  String get description =>
      'Add your google translate api key to the .env file';

  @override
  String get name => 'configure-translate-api';

  @override
  void run() => saveGoogleApiKey(argResults);
}
