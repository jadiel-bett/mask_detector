import 'package:flutter/material.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

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
          // Camera preview widget
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey[300], // Placeholder color for camera preview
            // Add camera preview widget here
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Trigger mask detection logic
              // Display results or navigate to result screen
            },
            child: const Text('Detect Mask'),
          ),
        ],
      ),
    );
  }
}
