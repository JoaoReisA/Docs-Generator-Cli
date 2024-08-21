import 'dart:async';
import 'dart:io';

Future<Map<String, String>> readFiles(String paths) async {
  final isADirectory = await FileSystemEntity.isDirectory(paths);

  if (!isADirectory || paths.isEmpty) {
    stderr.writeln('The path is not a directory');
    exit(1);
  }

  var files = <FileSystemEntity>[];
  var completer = Completer<List<FileSystemEntity>>();
  var lister = Directory(paths).list(recursive: true);
  lister.listen(
    (file) => files.add(file),
    onError: (e) {
      completer.completeError(e);
      stderr.writeln('Error reading files');
      exit(1);
    },
    onDone: () => completer.complete(files),
  );
  final filesAndDirList = await completer.future;
  final filesList = filesAndDirList.whereType<File>().toList();
  print(filesList);
  final filesAsStrings = <String, String>{};
  for (var file in filesList) {
    filesAsStrings[file.path] = await file.readAsString();
  }
  return filesAsStrings;
}
