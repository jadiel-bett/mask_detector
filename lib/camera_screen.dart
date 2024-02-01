import 'package:flutter/material.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});
  static const String id = "/camera";

  final Color teal = const Color(0xF001CEB2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mask Detection Camera'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Camera preview widget
          Container(
            height: 450,
            width: double.infinity,
            color: Colors.grey[300], // Placeholder color for camera preview
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
      ),
    );
  }
}
