import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> _cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});
  static const String id = "/camera";

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final Color teal = const Color(0xF001CEB2);
  late CameraController cameraController;
  late Future<void> initializeControllerFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cameras =
        ModalRoute.of(context)!.settings.arguments as List<CameraDescription>;
    // final firstCamera = _cameras.first;

    if (_cameras.isEmpty) {
      return;
    }

    cameraController = CameraController(_cameras[0], ResolutionPreset.max);

    initializeControllerFuture = cameraController.initialize();

    // cameraController.initialize().then((_) {
    //   if (!mounted) {
    //     return;
    //   }
    //   setState(() {});
    // }).catchError((Object e) {
    //   if (e is CameraException) {
    //     switch (e.code) {
    //       case 'CameraAccessDenied':
    //         // Handle access errors here.
    //         break;
    //       default:
    //         // Handle other errors here.
    //         break;
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _cameras = ModalRoute.of(context)!.settings.arguments as List;
    if (!cameraController.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mask Detection Camera'),
      ),
      body: FutureBuilder(
        future: initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(cameraController);
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Camera preview widget
                Container(
                  height: 450,
                  width: double.infinity,
                  color:
                      Colors.grey[300], // Placeholder color for camera preview
                  // Add camera preview widget here
                ),
                const SizedBox(height: 20),

                /// Detect Button
                ElevatedButton(
                  onPressed: () {
                    // Trigger mask detection logic
                    // Display results or navigate to result screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: teal,
                  ),
                  child: const Text(
                    'Detect Mask',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
