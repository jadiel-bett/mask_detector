import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MaskGuard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/mask_icon.png', // Replace with your mask icon
              height: 150,
              width: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to MaskGuard',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Your Personal Mask Guardian'),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navigate to the camera screen for mask detection
                Navigator.pushNamed(context, '/camera');
              },
              child: const Text('Start Mask Detection'),
            ),
          ],
        ),
      ),
    );
  }
}
