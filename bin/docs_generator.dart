import 'package:args/args.dart';
import 'package:docs_generator/generate_docs.dart';
import 'package:docs_generator/read_files.dart';

const pathFlag = 'path';
const apiKeyFlag = 'api-key';

void main(List<String> arguments) async {
  final parser = ArgParser()..addOption(pathFlag, abbr: 'p');
  parser.addOption(apiKeyFlag, abbr: 'k');
  ArgResults argResults = parser.parse(arguments);

  final paths = argResults.option(pathFlag) ?? '';
  final apiKey = argResults.option(apiKeyFlag) ?? '';

  final files = await readFiles(paths);
  generateDocs(files, apiKey);
}
