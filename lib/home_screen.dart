import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  final Color background = const Color(0xFFB4E2DC);

  final Color teal = const Color(0xF001CEB2);

  final Color textColor = const Color.fromARGB(255, 196, 227, 223);

  final String msg =
      'Your Personal Mask Guardian. Stay Safe, Stay Covered: Smart Detection for Safer Spaces';

  Future<void> _pickImageFromGallery() async {
    // TODO: Use the android photo picker package in image picker package
    XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      // Do something with the picked image, e.g., display it or process it
      print('Image Path: ${pickedImage.path}');
    } else {
      // User canceled the image picking process
      print('Image picking canceled.');
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(_scrollController.offset);
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage('assets/background_nurse.png'),
              fit: BoxFit.fitHeight,
              opacity: 0.1,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// Top Section
                  /// MaskGuard Logo
                  Padding(
                    padding: const EdgeInsets.only(top: 70, bottom: 15),
                    child: Image.asset(
                      'assets/mask_icon.png',
                      scale: 2,
                    ),
                  ),

                  /// Brand Name
                  Text(
                    'MaskGuard',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 30),

                  /// Intro Message
                  Text(
                    'Welcome to MaskGuard 👮‍♂️',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 70,
                      vertical: 8,
                    ),
                    child: Text(
                      msg,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  /// Start Detection Button
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 100),
                    child: ElevatedButton(
                      onPressed: () {
                        /// TODO: Animate the screen to scroll to reveal the bottom
                        /// section [mask detection section]
                        _scrollController.animateTo(
                          650,
                          duration: Durations.medium1,
                          curve: Curves.bounceInOut,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: teal,
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                      ),
                      child: const Text(
                        'Start Mask Detection',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),

                  /// Detection Page
                  /// Page Title
                  Text(
                    'Mask Detection',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  /// Gallery Detection
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Upload image from Gallery
                        GestureDetector(
                          onTap: () {
                            _pickImageFromGallery();
                          },
                          child: Card(
                            color: background,
                            elevation: 2,
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
                        ),
                        Text(
                          'Click the gallery icon to scan for masks \n from pictures in your gallery',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textColor,
                            fontStyle: FontStyle.italic,
                          ),
                        )
                      ],
                    ),
                  ),

                  /// Camera Detection
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// /// Use camera for mask detection
                        Text(
                          'Click the camera icon to scan for masks \n in your environment',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/camera');
                          },
                          child: Card(
                            color: background,
                            elevation: 2,
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
                        ),
                      ],
                    ),
                  ),

                  /// Scan Results
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: [
                        Text(
                          'Scan Results: ',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 500)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
