// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:test/test.dart';

void main() {
  test('URL launcher control test', () async {
    final List<MethodCall> log = <MethodCall>[];
  
    SystemChannels.platform.setMockMethodCallHandler((MethodCall methodCall) async {
      log.add(methodCall);
    });

    await UrlLauncher.launch('http://example.com/');

    expect(log, equals(<MethodCall>[new MethodCall('UrlLauncher.launch', 'http://example.com/')]));
  });
}
