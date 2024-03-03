import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mask_detector/camera_screen.dart';
import 'package:mask_detector/home_screen.dart';

late List<CameraDescription> _cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(cameras: [_cameras]),
      debugShowCheckedModeBanner: false,
      routes: {
        CameraScreen.id: (context) => const CameraScreen(),
      },
    );
  }
}
