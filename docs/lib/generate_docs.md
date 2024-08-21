```dart
import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

/// Generates Markdown documentation for Dart code snippets using the Gemini Pro model.
///
/// This function takes a map of filenames and code snippets and generates a Markdown documentation file for each snippet.
/// The documentation is generated using the Gemini Pro model, which follows Markdown best practices.
///
/// **Arguments:**
///
/// * `files`: A map of filenames (keys) and code snippets (values) to be documented.
/// * `apiKey`: Your Google Generative AI API key.
///
/// **Example:**
///
/// ```dart
/// final files = {
///   'my_function.dart': '// This is a function\nvoid myFunction() { ... }',
///   'another_file.dart': '// This is another file\nclass MyClass { ... }',
/// };
///
/// generateDocs(files, 'YOUR_API_KEY');
/// ```
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
```

## Documentation

This code snippet defines a function `generateDocs` that takes a map of Dart code snippets and generates Markdown documentation for each snippet. 

### Function Signature

```dart
void generateDocs(Map<String, String> files, String apiKey) async { ... }
```

### Parameters

* `files`: A map of filenames (keys) and code snippets (values) to be documented.
* `apiKey`: Your Google Generative AI API key.

### Functionality

1. **Initializes a GenerativeModel instance**: Uses the `gemini-1.5-flash-latest` model and your API key.
2. **Iterates over each file in the `files` map**:
   * Constructs a prompt asking the Gemini model to generate Markdown documentation for the corresponding code snippet.
   * Sends the prompt to the model using `model.generateContent`.
   * Creates a Markdown file (`docs/${key.replaceAll('.dart', '.md')}`) and writes the generated documentation to it.
   * Prints a message indicating the file creation.

### Usage Example

```dart
final files = {
  'my_function.dart': '// This is a function\nvoid myFunction() { ... }',
  'another_file.dart': '// This is another file\nclass MyClass { ... }',
};

generateDocs(files, 'YOUR_API_KEY');
```

This example demonstrates how to use the `generateDocs` function to generate documentation for two Dart files: `my_function.dart` and `another_file.dart`. 

**Note:** Remember to replace `'YOUR_API_KEY'` with your actual Google Generative AI API key.
