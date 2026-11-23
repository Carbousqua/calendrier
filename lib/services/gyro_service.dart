import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroService {
  StreamSubscription<GyroscopeEvent>? _gyroSub;
  StreamSubscription<AccelerometerEvent>? _accelSub;
  Timer? _smoothTimer;

  final ValueNotifier<Offset> tilt = ValueNotifier(Offset.zero);

  Offset _gyroTarget = Offset.zero;
  Offset _accelTarget = Offset.zero;
  Offset _current = Offset.zero;

  static const double _gyroSens = 0.022;
  static const double _accelSens = 0.45;
  static const double _max = 0.75;
  static const double _lerp = 0.16;
  static const double _decay = 0.030;

  bool get isActive => _gyroSub != null || _accelSub != null;

  void start() {
    if (isActive) return;

    // 1. Gyroscope Stream (Dynamic rotational velocity)
    try {
      _gyroSub = gyroscopeEventStream(
        samplingPeriod: SensorInterval.gameInterval,
      ).listen(
        (event) {
          _gyroTarget = Offset(
            (_gyroTarget.dx + event.y * _gyroSens).clamp(-_max, _max),
            (_gyroTarget.dy - event.x * _gyroSens).clamp(-_max, _max),
          );
        },
        onError: (_) => _stopGyroStream(),
      );
    } catch (_) {}

    // 2. Accelerometer Stream (Physical static tilt angle)
    try {
      _accelSub = accelerometerEventStream(
        samplingPeriod: SensorInterval.gameInterval,
      ).listen(
        (event) {
          // Normalize X & Y gravity tilt (-9.8 to +9.8) to offset (-1.0 to +1.0)
          final tx = (event.x / 7.0).clamp(-1.0, 1.0) * _accelSens;
          final ty = ((event.y - 4.0) / 7.0).clamp(-1.0, 1.0) * _accelSens;
          _accelTarget = Offset(tx.clamp(-_max, _max), ty.clamp(-_max, _max));
        },
        onError: (_) => _stopAccelStream(),
      );
    } catch (_) {}

    // 3. Smooth 60 FPS Physics Engine Interpolation
    _smoothTimer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      final combinedTarget = Offset(
        (_gyroTarget.dx + _accelTarget.dx).clamp(-_max, _max),
        (_gyroTarget.dy + _accelTarget.dy).clamp(-_max, _max),
      );

      _current = Offset.lerp(_current, combinedTarget, _lerp)!;
      _gyroTarget = Offset.lerp(_gyroTarget, Offset.zero, _decay)!;
      tilt.value = _current;
    });
  }

  void _stopGyroStream() {
    _gyroSub?.cancel();
    _gyroSub = null;
  }

  void _stopAccelStream() {
    _accelSub?.cancel();
    _accelSub = null;
  }

  void stop() {
    _stopGyroStream();
    _stopAccelStream();
    _smoothTimer?.cancel();
    _smoothTimer = null;
    _gyroTarget = Offset.zero;
    _accelTarget = Offset.zero;
    _current = Offset.zero;
    tilt.value = Offset.zero;
  }

  void dispose() {
    stop();
    tilt.dispose();
  }
}
