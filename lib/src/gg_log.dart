// @license
// Copyright (c) 2019 - 2024 Dr. Gabriel Gatzsche. All Rights Reserved.
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

/// GgLog is a function that logs a message.
typedef GgLog = void Function(String message);

/// An implementation of [GgLog] that logs to the console.
GgLog testGgLog = (String message) {
  print('GgLog: $message');
};
