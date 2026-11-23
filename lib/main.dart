import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/month_data.dart';
import 'services/gyro_service.dart';
import 'theme/app_colors.dart';
import 'widgets/backdrop.dart';
import 'widgets/bottom_panel.dart';
import 'widgets/easel_area.dart';
import 'widgets/header.dart';
import 'widgets/slim_bar.dart';

// ─────────────────────────────────────────────────────────────
//  DILI PRESTIGE — Calendrier Chevalet Premium
//  Version finale optimisée et modularisée
// ─────────────────────────────────────────────────────────────

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF07080C),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Cache d'images raisonnable pour mobile
  PaintingBinding.instance.imageCache
    ..maximumSizeBytes = 80 << 20 // 80 Mo
    ..maximumSize = 48;

  runApp(const DiliPrestigeCalendarApp());
}

// ───────────────────── App ─────────────────────
class DiliPrestigeCalendarApp extends StatelessWidget {
  const DiliPrestigeCalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dili Prestige - Calendrier de Bureau',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.bgDark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.gold,
          brightness: Brightness.dark,
          primary: AppColors.goldLight,
          secondary: AppColors.royalBlueLight,
          surface: AppColors.surface,
        ),
        fontFamily: 'sans-serif',
        useMaterial3: true,
      ),
      home: const CalendarPresentationPage(),
    );
  }
}

// ───────────────────── Page principale ─────────────────────
class CalendarPresentationPage extends StatefulWidget {
  const CalendarPresentationPage({super.key});

  @override
  State<CalendarPresentationPage> createState() =>
      _CalendarPresentationPageState();
}

class _CalendarPresentationPageState extends State<CalendarPresentationPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  static const double _chipExtent = 66;

  late final PageController _pageController;
  final ScrollController _chipsController = ScrollController();

  int _currentIndex = 0;
  bool _isPlaying = false;
  bool _rotated = false;
  bool _showHint = true;
  bool _precached = false;
  bool _useGyro = true;
  bool _mouseActive = false;

  Timer? _autoPlayTimer;
  Timer? _hintTimer;

  final ValueNotifier<Offset> _tilt = ValueNotifier(Offset.zero);
  final GyroService _gyro = GyroService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _pageController = PageController();
    _hintTimer = Timer(const Duration(seconds: 6), () {
      if (mounted) setState(() => _showHint = false);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final isMobile = MediaQuery.sizeOf(context).shortestSide < 600;
      if (isMobile && _useGyro) _startGyro();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_precached) {
      _precached = true;
      _precacheAround(_currentIndex);
    }
  }

  void _precacheAround(int index) {
    final count = calendarMonths.length;
    final indicesToCache = {
      index,
      (index + 1) % count,
      (index - 1 + count) % count,
    };
    for (final i in indicesToCache) {
      precacheImage(getMonthImage(calendarMonths[i]), context);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopGyro();
    _autoPlayTimer?.cancel();
    _hintTimer?.cancel();
    _pageController.dispose();
    _chipsController.dispose();
    _tilt.dispose();
    _gyro.dispose();
    super.dispose();
  }

  // ───────── Lifecycle ─────────
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        _pauseBackground();
      case AppLifecycleState.resumed:
        _resumeBackground();
      case AppLifecycleState.detached:
        break;
    }
  }

  void _pauseBackground() {
    if (_gyro.isActive) _gyro.stop();
    _autoPlayTimer?.cancel();
    _autoPlayTimer = null;
  }

  void _resumeBackground() {
    if (!mounted) return;
    final isMobile = MediaQuery.sizeOf(context).shortestSide < 600;
    if (_useGyro && isMobile && !_mouseActive) {
      _startGyro();
    }
    if (_isPlaying) {
      _autoPlayTimer?.cancel();
      _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (_) => _next());
    }
  }

  // ───────── Gyro ─────────
  void _startGyro() {
    _gyro.start();
    _gyro.tilt.addListener(_onGyroTilt);
  }

  void _stopGyro() {
    _gyro.tilt.removeListener(_onGyroTilt);
    _gyro.stop();
  }

  void _onGyroTilt() {
    if (!_mouseActive) {
      _tilt.value = _gyro.tilt.value;
    }
  }

  void _toggleGyro() {
    setState(() {
      _useGyro = !_useGyro;
      if (_useGyro) {
        final isMobile = MediaQuery.sizeOf(context).shortestSide < 600;
        if (isMobile) _startGyro();
      } else {
        _stopGyro();
        if (!_mouseActive) _tilt.value = Offset.zero;
      }
    });
  }

  // ───────── Navigation ─────────
  void _goTo(int index) {
    if (index < 0 || index >= calendarMonths.length) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 480),
      curve: Curves.easeInOutCubic,
    );
  }

  void _next() => _goTo((_currentIndex + 1) % calendarMonths.length);

  void _previous() =>
      _goTo((_currentIndex - 1 + calendarMonths.length) % calendarMonths.length);

  void _onPageChanged(int i) {
    HapticFeedback.selectionClick();
    setState(() {
      _currentIndex = i;
      _showHint = false;
    });
    _centerChip(i);
    _precacheAround(i);
  }

  void _centerChip(int i) {
    if (!_chipsController.hasClients) return;
    final pos = _chipsController.position;
    final target =
        (i * _chipExtent + _chipExtent / 2 - pos.viewportDimension / 2)
            .clamp(0.0, pos.maxScrollExtent);
    _chipsController.animateTo(
      target,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOut,
    );
  }

  void _toggleAutoPlay() {
    setState(() {
      _isPlaying = !_isPlaying;
      _autoPlayTimer?.cancel();
      if (_isPlaying) {
        _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (_) => _next());
      }
    });
  }

  void _toggleRotated() {
    HapticFeedback.lightImpact();
    setState(() => _rotated = !_rotated);
  }

  // ───────── Build ─────────
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final compact = size.shortestSide < 600;
    final landscape = size.width > size.height;
    final slim = compact && landscape;
    final rotated = _rotated && compact && !landscape;
    final currentMonth = calendarMonths[_currentIndex];

    return Scaffold(
      body: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.arrowRight): _next,
          const SingleActivator(LogicalKeyboardKey.arrowLeft): _previous,
          const SingleActivator(LogicalKeyboardKey.space): _toggleAutoPlay,
        },
        child: Focus(
          autofocus: true,
          child: Stack(
            children: [
              const Positioned.fill(child: Backdrop()),
              SafeArea(
                child: Column(
                  children: [
                    if (!slim)
                      Header(
                        compact: compact,
                        canRotate: compact && !landscape,
                        rotated: rotated,
                        useGyro: _useGyro,
                        onToggleGyro: _toggleGyro,
                        onToggleRotated: _toggleRotated,
                      ),
                    Expanded(
                      child: EaselArea(
                        compact: compact,
                        rotated: rotated,
                        tilt: _tilt,
                        mouseActive: _mouseActive,
                        onMouseHover: (active, offset) {
                          _mouseActive = active;
                          if (active) {
                            _tilt.value = offset;
                          } else if (!_useGyro) {
                            _tilt.value = Offset.zero;
                          }
                        },
                        pageController: _pageController,
                        onPageChanged: _onPageChanged,
                        currentIndex: _currentIndex,
                      ),
                    ),
                    if (slim)
                      SlimBar(
                        currentMonth: currentMonth,
                        currentIndex: _currentIndex,
                        isPlaying: _isPlaying,
                        onPrevious: _previous,
                        onNext: _next,
                        onToggleAutoPlay: _toggleAutoPlay,
                      )
                    else
                      BottomPanel(
                        compact: compact,
                        rotated: rotated,
                        currentMonth: currentMonth,
                        currentIndex: _currentIndex,
                        isPlaying: _isPlaying,
                        showHint: _showHint,
                        chipsController: _chipsController,
                        onPrevious: _previous,
                        onNext: _next,
                        onToggleAutoPlay: _toggleAutoPlay,
                        onGoTo: _goTo,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
