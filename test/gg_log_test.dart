// @license
// Copyright (c) 2019 - 2024 Dr. Gabriel Gatzsche. All Rights Reserved.
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import 'package:gg_log/gg_log.dart';
import 'package:test/test.dart';

void main() {
  final messages = <String>[];

  setUp(() {
    messages.clear();
  });

  group('GgLog()', () {
    group('testGgLog(msg)', () {
      test('should print message to console', () {
        testGgLog('Hello, World!', print: messages.add);
        expect(messages, ['GgLog: Hello, World!']);
      });
    });
  });
}
