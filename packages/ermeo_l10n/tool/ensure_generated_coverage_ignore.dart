// Ensures gen-l10n output under lib/src/generated/ keeps coverage:ignore-file.
import 'dart:io';

const _header = '// coverage:ignore-file\n';
const _generatedDir = 'lib/src/generated';

void main() {
  final dir = Directory(_generatedDir);
  if (!dir.existsSync()) {
    stderr.writeln('$_generatedDir not found; run flutter gen-l10n first.');
    exitCode = 1;
    return;
  }

  for (final entity in dir.listSync()) {
    if (entity is! File || !entity.path.endsWith('.dart')) {
      continue;
    }
    final contents = entity.readAsStringSync();
    if (contents.startsWith('// coverage:ignore-file')) {
      continue;
    }
    entity.writeAsStringSync('$_header$contents');
  }
}
