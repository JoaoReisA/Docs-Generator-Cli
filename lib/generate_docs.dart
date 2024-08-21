import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

void generateDocs(Map<String, String> files, String apiKey) async {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: apiKey,
  );

  files.forEach((key, value) async {
    final prompt =
        '''Generate documentation in Markdown for the following code snippet in dart language using the best practices of Markdown writing:\n\n
    $value
    ''';

    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    final file = File('docs/${key.replaceAll('.dart', '.md')}')
      ..createSync(recursive: true);

    file.writeAsStringSync(response.text ?? '');
    print('File with name ${file.path} created');
  });
}
