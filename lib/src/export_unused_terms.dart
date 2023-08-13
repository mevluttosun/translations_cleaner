import 'dart:io';

import 'package:translations_manager/src/models/term.dart';

void exportTerms(Set<Term> notUsed, String? outputPath, {String? filename}) {
  if (outputPath == null) {
    print('⛔️ No outputPath provided, using default path');
  }

  outputPath ??= Directory.current.path;
  var file = File('$outputPath/${filename ?? 'unused-translations'}.txt');
  final buffer = StringBuffer();
  buffer.writeAll(notUsed.map((e) => '${e.key}\n'));
  file.writeAsString(buffer.toString());
  print('✅ Saved in $outputPath/${filename ?? 'unused-translations'}.txt');
}
