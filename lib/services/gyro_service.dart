import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroService {
  StreamSubscription<GyroscopeEvent>? _sub;
  Timer? _smoothTimer;

  final ValueNotifier<Offset> tilt = ValueNotifier(Offset.zero);

  Offset _target = Offset.zero;
  Offset _current = Offset.zero;

  static const double _sens = 0.013;
  static const double _max = 0.55;
  static const double _lerp = 0.14;
  static const double _decay = 0.035;

  bool get isActive => _sub != null;

  void start() {
    if (_sub != null) return;

    _sub = gyroscopeEventStream(
      samplingPeriod: SensorInterval.gameInterval,
    ).listen(
      (event) {
        _target = Offset(
          (_target.dx + event.y * _sens).clamp(-_max, _max),
          (_target.dy - event.x * _sens).clamp(-_max, _max),
        );
      },
      onError: (_) => stop(),
    );

    _smoothTimer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      _current = Offset.lerp(_current, _target, _lerp)!;
      _target = Offset.lerp(_target, Offset.zero, _decay)!;
      tilt.value = _current;
    });
  }

  void stop() {
    _sub?.cancel();
    _sub = null;
    _smoothTimer?.cancel();
    _smoothTimer = null;
    _target = Offset.zero;
    _current = Offset.zero;
    tilt.value = Offset.zero;
  }

  void dispose() {
    stop();
    tilt.dispose();
  }
}
