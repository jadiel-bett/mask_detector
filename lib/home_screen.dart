import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

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

  bool isMaskOn = false;
  bool isImageReady = false;
  bool busy = false;
  XFile? image;
  dynamic imageResult;

  Future loadModel() async {
    Tflite.close();
    try {
      var res = await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt",
        numThreads: 1, // defaults to 1
        isAsset:
            true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate:
            false, // defaults to false, set to true to use GPU delegate
      );

      print(res);
    } on PlatformException {
      print('Failed to load model.');
    }
  }

  String truncateTo2dp(double value) {
    var result = (value * 100).toString().substring(0, 6);
    return result;
  }

  void detectMaskOnImage(String path) async {
    int startTime = DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.runModelOnImage(
      path: path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      imageResult = recognitions![0];
      isMaskOn = imageResult['label'] == 'Mask On' ? true : false;
      truncateTo2dp(imageResult['confidence']);
    });
    int endTime = DateTime.now().millisecondsSinceEpoch;
    print(imageResult['label'] == '0 Mask On');
    print("Inference took ${endTime - startTime}ms");
  }

  Future<void> _pickImageFromGallery() async {
    // TODO: Use the android photo picker package in image picker package
    XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
        isImageReady = true;
      });

      // Perform Image classification / Identify whether mask is on
      detectMaskOnImage(pickedImage.path);
    } else {
      // User canceled the image picking process
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
  void initState() {
    super.initState();
    busy = true;
    loadModel().then((value) {
      setState(() {
        busy = true;
      });
    });
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
              opacity: 0.05,
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
                  isImageReady
                      ? Column(
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
                                    imageResult['label'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: isMaskOn ? teal : Colors.red,
                                    ),
                                  ),
                                  Text(
                                    '  (${truncateTo2dp(imageResult['confidence'])}%)',
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
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      color: textColor,
                                    ),
                            ),
                            const SizedBox(height: 30),

                            // Back Button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: teal,
                                elevation: 2,
                              ),
                              onPressed: () {
                                // Navigate back to the home screen or any other action
                                setState(() {
                                  isImageReady = false;
                                });
                                _scrollToHome();
                              },
                              child: const Text(
                                'Detect Again',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 100)
                          ],
                        )
                      : const SizedBox(height: 500)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
