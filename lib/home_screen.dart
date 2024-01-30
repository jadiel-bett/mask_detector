import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final Color background = const Color(0xFFB4E2DC);
  final Color teal = const Color(0xF001CEB2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Image.asset(
                  'assets/mask_icon.png',
                  scale: 4,
                ),
              ),
              const Text(
                'MaskGuard',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'Welcome to MaskGuard',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text('Your Personal Mask Guardian'),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  /// Navigates to the camera screen for mask detection
                  Navigator.pushNamed(context, '/camera');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: teal,
                ),
                child: const Text(
                  'Start Mask Detection',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    color: background,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(20),
                    child: const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Icon(
                        Icons.photo,
                        size: 60,
                      ),
                    ),
                  ),

                  /// Use camera for mask detection
                  Card(
                    color: background,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(20),
                    child: const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Icon(
                        Icons.camera,
                        size: 60,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
