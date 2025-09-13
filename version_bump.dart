import 'dart:io';

void main() {
  const pubspecPath = 'pubspec.yaml';
  final pubspecFile = File(pubspecPath);

  if (!pubspecFile.existsSync()) {
    print('pubspec.yaml file not found!');
    exit(1);
  }

  final content = pubspecFile.readAsStringSync();
  final versionRegex = RegExp(r'version:\s(\d+)\.(\d+)\.(\d+)\+(\d+)');

  final match = versionRegex.firstMatch(content);
  if (match == null) {
    print('Version not found in pubspec.yaml!');
    exit(1);
  }

  final major = int.parse(match.group(1)!);
  final minor = int.parse(match.group(2)!);
  final patch = int.parse(match.group(3)!);
  final build = int.parse(match.group(4)!);

  // Increment build number
  final newPatch = patch + 1;
  final newVersion = '$major.$minor.$newPatch+$build';

  final updatedContent =
  content.replaceFirst(versionRegex, 'version: $newVersion');

  pubspecFile.writeAsStringSync(updatedContent);
  print('Updated version to: $newVersion');
}
