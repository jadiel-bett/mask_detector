import 'package:flutter/material.dart';
import 'package:mask_detector/camera_screen.dart';
import 'package:mask_detector/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        CameraScreen.id: (context) => const CameraScreen(),
      },
    );
  }
}
