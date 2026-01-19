import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:subterfuge/features/home/page.dart';
import 'package:subterfuge/shared/theme.dart';
import 'package:window_manager/window_manager.dart';

const Size _minimalSize = Size(320, 640);
const Size _defaultSize = Size(450, 750);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    await windowManager.ensureInitialized();

    await windowManager.setMinimumSize(_minimalSize);
    await windowManager.setSize(_defaultSize);
    await windowManager.center();
    await windowManager.show();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Subterfuge',
      theme: appTheme,
      home: const HomePage(),
    );
  }
}
