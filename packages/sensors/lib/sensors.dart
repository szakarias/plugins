import 'dart:async';

import 'package:flutter/services.dart';

const EventChannel _accelerometerEventChannel =
    const EventChannel('plugins.flutter.io/accelerometer');

const EventChannel _gyroscopeEventChannel =
    const EventChannel('plugins.flutter.io/gyroscope');

class AccelerometerEvent {
  /// Acceleration force along the x axis (including gravity) measured in m/s^2.
  double x;

  /// Acceleration force along the y axis (including gravity) measured in m/s^2.
  double y;

  /// Acceleration force along the z axis (including gravity) measured in m/s^2.
  double z;

  AccelerometerEvent(this.x, this.y, this.z);
}

class GyroscopeEvent {
  /// Rate of rotation around the x axis measured in rad/s.
  double x;

  /// Rate of rotation around the y axis measured in rad/s.
  double y;

  /// Rate of rotation around the z axis measured in rad/s.
  double z;

  GyroscopeEvent(this.x, this.y, this.z);
}

AccelerometerEvent _listToAccelerometerEvent(List<double> list) {
  return new AccelerometerEvent(list[0], list[1], list[2]);
}

GyroscopeEvent _listToGyroscopeEvent(List<double> list) {
  return new GyroscopeEvent(list[0], list[1], list[2]);
}

Stream<AccelerometerEvent> _accelerometerEvents;
Stream<GyroscopeEvent> _gyroscopeEvents;

/// A broadcast stream of events from the device accelerometer.
Stream<AccelerometerEvent> get accelerometerEvents {
  if (_accelerometerEvents == null) {
    _accelerometerEvents = _accelerometerEventChannel
        .receiveBroadcastStream()
        .map(_listToAccelerometerEvent);
  }
  return _accelerometerEvents;
}

/// A broadcast stream of events from the device gyroscope.
Stream<GyroscopeEvent> get gyroscopeEvents {
  if (_gyroscopeEvents == null) {
    _gyroscopeEvents = _gyroscopeEventChannel
        .receiveBroadcastStream()
        .map(_listToGyroscopeEvent);
  }
  return _gyroscopeEvents;
}
