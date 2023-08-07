import 'dart:io';

import 'package:args/args.dart';

/// Save google api key to the .env file
Future<void> saveGoogleApiKey(ArgResults? argResults) async {
  final key = argResults?.arguments[0];
  if (key?.isEmpty ?? true) {
    print('Please provide a valid key');
    return;
  }
  final file = File('.env');
  if (!file.existsSync()) {
    print('No .env file found, creating one');
    await file.create();
  }
  final envFile = await file.readAsString();
  if (envFile.contains('GOOGLE_API_KEY')) {
    print('GOOGLE_API_KEY already exists in .env file');
    return;
  }
  await file.writeAsString('$envFile\nGOOGLE_API_KEY=$key');
  print('GOOGLE_API_KEY saved to .env file');
}

/// get google api key from the .env file
/// returns null if no key is found
/// throws an exception if the .env file is not found
/// or if the GOOGLE_API_KEY is not found in the file
/// or if the GOOGLE_API_KEY is empty
Future<String> getApiKey() async {
  String? key;
  final file = File('.env');
  if (!file.existsSync()) {
    throw Exception('No .env file found');
  }
  final envFile = await file.readAsString();
  if (!envFile.contains('GOOGLE_API_KEY')) {
    throw Exception('GOOGLE_API_KEY not found in .env file');
  }
  try {
    key = envFile.split('GOOGLE_API_KEY=')[1];
  } catch (e) {
    throw Exception('GOOGLE_API_KEY is empty');
  }
  return key;
}
