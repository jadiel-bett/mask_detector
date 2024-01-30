import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final bool isMaskOn; // Pass this value based on the detection result

  const ResultScreen({super.key, required this.isMaskOn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mask Detection Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isMaskOn ? Icons.check_circle : Icons.cancel,
              color: isMaskOn ? Colors.green : Colors.red,
              size: 100,
            ),
            const SizedBox(height: 20),
            Text(
              isMaskOn ? 'Mask On!' : 'Mask Off!',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the home screen or any other action
                Navigator.pop(context);
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
