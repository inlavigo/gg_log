// @license
// Copyright (c) 2019 - 2024 Dr. Gabriel Gatzsche. All Rights Reserved.
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

void main() {
  // #########################################################################
  group('.vscode/launch.json', () {
    test('pathes in launch.json', () {
      const String launchJsonPath = '.vscode/launch.json';
      final String launchJson = File(launchJsonPath)
          .readAsStringSync()
          .replaceAll(RegExp(r'//.*'), '');

      final parsedLaunchJson = jsonDecode(launchJson) as Map<String, dynamic>;

      // Ensure there is a configuration for executing bin/gg_log.dart
      final configurations =
          parsedLaunchJson['configurations'] as List<dynamic>;

      final ggLog = configurations.firstWhere(
        (dynamic configuration) =>
            configuration['name'].toString() == 'gg_log.dart',
      );

      expect(
        ggLog,
        isNotNull,
        reason: 'Item for executing bin/gg_log.dart not found',
      );

      expect(ggLog['name'], 'gg_log.dart');
      expect(ggLog['type'], 'dart');
      expect(ggLog['request'], 'launch');

      // Ensure there is a coniguration for executing the current file
      final currentFile = parsedLaunchJson['configurations'].firstWhere(
        (dynamic configuration) => configuration['name'] == 'Current File',
      );
      expect(
        currentFile,
        isNotNull,
        reason: 'Item for executing current file not found',
      );
      expect(currentFile['type'], 'dart');
      expect(currentFile['request'], 'launch');
      expect(currentFile['program'], r'${file}');

      // Test other configurations
      for (final configuration
          in parsedLaunchJson['configurations'] as Iterable) {
        final program = configuration['program'].toString();
        expect(program, isNotNull);
        expect(program, isNotEmpty);
        if (program.contains('{workspaceFolder}')) {
          final resolved = program.replaceAll(r'${workspaceFolder}', '.');
          final file = File(resolved);
          expect(file.existsSync(), isTrue);
          final content = file.readAsStringSync();
          if (file.path.endsWith('.dart')) {
            expect(content, contains('main('));
          }
        }
      }
    });
  });
}
