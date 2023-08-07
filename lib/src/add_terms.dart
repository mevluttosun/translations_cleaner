import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:translations_manager/src/models/term.dart';
import 'package:translations_manager/src/save_google_api_key.dart';
import 'package:translations_manager/src/translation_files.dart';
import 'package:translations_manager/src/translation_terms.dart';

/// Add new terms to
Future<void> addTerms(ArgResults? argResults) async {
  final bool isSaveEnabled = argResults?['save'] ?? true;
  final term = argResults?.rest.join(" ");
  final terms = getTranslationTerms();
  final isTermAdded = terms.where(
    (element) => element.key == term,
  );
  if (isTermAdded.isNotEmpty) {
    print('Term already added');
    exit(0);
  }
  final files = translationFiles();

  final supportedLanguages = files.map((e) {
    return e.path.split('/').last;
  }).toList();
  print(
      'Supported languages: ${supportedLanguages.map((e) => e.split('_').first).toList()}');
  print("🌎 🌍 🌏 Translating terms into supported languages 🌎 🌍 🌏");

  Set<Term> translatedTerms = {};
  for (final language in supportedLanguages) {
    final translatedTerm =
        await translateWord(term!, language.split('_').first);
    if (translatedTerm != null) {
      translatedTerms
          .addAll({Term(key: term, value: translatedTerm, filename: language)});
    }
  }
  for (var translate in translatedTerms) {
    print('🟢 ${translate.filename} => ${translate.key}: ${translate.value}');
  }
  print('-------------------');
  // if save is enabled then save the term to the files
  if (isSaveEnabled) {
    await Future.wait(translatedTerms.map((e) => _addTermToFile(e)));
    print('Term added to the files');
    //end command line
    exit(0);
  }

  //ask again using command line if save is not enabled to save the term to the files
  if (!isSaveEnabled) {
    print('Do you want to save the term to the files? (yes/no)');
    final answer = stdin.readLineSync();
    if (answer == 'yes') {
      print('Saving the term to the files');
      await Future.wait(translatedTerms.map((e) => _addTermToFile(e)));
      print('Term added to the files');
      //end command line
      exit(0);
    } else {
      print('Term not added to the files');
      //end command line
      exit(0);
    }
  }
}

Future<void> _addTermToFile(Term term) async {
  final file = translationFiles().firstWhere(
      (element) => element.path.split('/').last.contains(term.filename));
  final fileString = await File(file.path).readAsString();
  Map<String, dynamic> fileJson = {};
  try {
    fileJson = jsonDecode(fileString);
  } catch (e) {
    File(file.path).writeAsString(JsonEncoder.withIndent(' ' * 4).convert({}));
  }
  fileJson.addAll({term.key: term.value});
  // Indent is being used for proper formatting
  await File(file.path)
      .writeAsString(JsonEncoder.withIndent(' ' * 4).convert(fileJson));
}

Future<String?> translateWord(String word, String language) async {
  final key = await getApiKey();
  final url =
      'https://translation.googleapis.com/language/translate/v2?key=$key';
  final response = await HttpClient().postUrl(Uri.parse(url))
    ..headers.contentType = ContentType.parse("application/json; charset=utf-8")
    ..write(jsonEncode(
        {'q': word, 'target': language, 'format': 'text', 'model': 'base'}));
  final body = await response
      .close()
      .then((value) => value.transform(utf8.decoder).join());
  final json = jsonDecode(body);
  return json['data']['translations'][0]['translatedText'];
}
