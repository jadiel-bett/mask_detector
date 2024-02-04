import 'dart:io';

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

  bool isMaskOn = true;
  bool isImageReady = false;
  XFile? image;

  Future<void> _pickImageFromGallery() async {
    // TODO: Use the android photo picker package in image picker package
    XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      // Do something with the picked image, e.g., display it or process it
      print('Image Path: ${pickedImage.path}');
      setState(() {
        image = pickedImage;
        isImageReady = true;
      });
    } else {
      // User canceled the image picking process
      print('Image picking canceled.');
    }
  }

  void _scrollToHome() {
    _scrollController.animateTo(
      650,
      duration: Durations.medium1,
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      onPressed: _scrollToHome,
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
                            _pickImageFromGallery().then((value) {
                              isImageReady
                                  ? _scrollController.animateTo(
                                      887,
                                      duration: Durations.medium1,
                                      curve: Curves.ease,
                                    )
                                  : null;
                            });
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
                    padding: const EdgeInsets.only(left: 20.0, top: 20),
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
                  ///
                  Visibility(
                    visible: isImageReady,
                    child: Column(
                      children: [
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
                              Text(
                                isMaskOn ? 'Mask On!' : 'Mask Off!',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: isMaskOn ? teal : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// Image container
                        Container(
                          decoration: BoxDecoration(
                            border: isImageReady
                                ? Border(
                                    top: BorderSide(
                                      width: 5.0,
                                      color: isMaskOn ? teal : Colors.red,
                                    ),
                                    bottom: BorderSide(
                                      width: 5.0,
                                      color: isMaskOn ? teal : Colors.red,
                                    ),
                                    right: BorderSide(
                                      width: 5.0,
                                      color: isMaskOn ? teal : Colors.red,
                                    ),
                                    left: BorderSide(
                                      width: 5.0,
                                      color: isMaskOn ? teal : Colors.red,
                                    ),
                                  )
                                : const Border(),
                          ),
                          child: isImageReady
                              ? Image.file(
                                  File(image!.path),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                )
                              : Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  color: textColor,
                                ),
                        ),
                        const SizedBox(height: 30),

                        // Back Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: background,
                            elevation: 2,
                          ),
                          onPressed: () {
                            // Navigate back to the home screen or any other action
                            _scrollToHome();
                          },
                          child: const Text(
                            '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
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
