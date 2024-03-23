// @license
// Copyright (c) 2019 - 2024 Dr. Gabriel Gatzsche. All Rights Reserved.
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:gg_capture_print/gg_capture_print.dart';
import 'package:gg_log/gg_log.dart';
import 'package:test/test.dart';
import 'package:gg_args/gg_args.dart';

void main() {
  final messages = <String>[];

  setUp(() {
    messages.clear();
  });

  group('GgLog()', () {
    // #########################################################################
    group('GgLog', () {
      final ggLog = GgLog(log: (msg) => messages.add(msg));

      final CommandRunner<void> runner = CommandRunner<void>(
        'ggLog',
        'Description goes here.',
      )..addCommand(ggLog);

      test('should allow to run the code from command line', () async {
        await capturePrint(
          log: messages.add,
          code: () async =>
              await runner.run(['ggLog', 'my-command', '--input', 'foo']),
        );
        expect(messages, contains('Running my-command with param foo'));
      });

      // .......................................................................
      test('should show all sub commands', () async {
        final (subCommands, errorMessage) = await missingSubCommands(
          directory: Directory('lib/src/commands'),
          command: ggLog,
        );

        expect(subCommands, isEmpty, reason: errorMessage);
      });
    });
  });
}
