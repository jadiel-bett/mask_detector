# MaskGuard 👮‍♂️

A Flutter-based mobile application that uses machine learning to detect whether individuals are wearing face masks in real-time or from images.

## Overview

MaskGuard is an AI-powered mask detection application built with Flutter and TensorFlow Lite. It provides two detection modes: real-time camera detection and image-based detection from your gallery. The app uses a trained TensorFlow Lite model to classify images and determine mask compliance with confidence scores.

## Features

- **Real-time Camera Detection**: Use your device camera to detect masks in real-time
- **Gallery Image Detection**: Upload images from your gallery for mask detection
- **Confidence Scoring**: Get percentage-based confidence scores for each detection
- **Visual Feedback**: Color-coded results (green for mask on, red for mask off)
- **Cross-platform**: Runs on Android, iOS, and Web
- **Offline Capability**: Model runs locally on device without internet connection

## Screenshots

The app features:
- Welcome screen with branding and introduction
- Detection interface with gallery and camera options
- Results display with confidence percentages
- Visual indicators for mask compliance

## Technology Stack

- **Framework**: Flutter 3.2.5+
- **Machine Learning**: TensorFlow Lite v2
- **Camera**: Flutter Camera Plugin
- **Image Processing**: Image Picker Plugin
- **Model**: Custom trained TFLite model for mask detection

## Prerequisites

Before running this project, ensure you have:

- Flutter SDK (3.2.5 or higher)
- Dart SDK (included with Flutter)
- Android Studio / Xcode (for mobile development)
- A physical device or emulator with camera support

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/mask_detector.git
cd mask_detector
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart              # App entry point and routing
├── home_screen.dart       # Main screen with detection options
├── camera_screen.dart     # Real-time camera detection
└── results_screen.dart    # Detection results display

assets/
├── model_unquant.tflite   # TensorFlow Lite model
├── labels.txt             # Model labels (Mask On/Mask Off)
├── mask_icon.png          # App icon
└── background_nurse.png   # Background image
```

## Usage

### Gallery Detection
1. Launch the app
2. Tap "Start Mask Detection"
3. Click the gallery icon
4. Select an image from your device
5. View the detection results with confidence score

### Camera Detection
1. Launch the app
2. Tap "Start Mask Detection"
3. Click the camera icon
4. Grant camera permissions if prompted
5. Point camera at subject for real-time detection

## Model Information

The app uses a custom TensorFlow Lite model (`model_unquant.tflite`) trained to classify images into two categories:
- **Mask On**: Person is wearing a face mask
- **Mask Off**: Person is not wearing a face mask

The model provides confidence scores as percentages to indicate detection certainty.

## Configuration

### Camera Permissions

**Android** (`android/app/src/main/AndroidManifest.xml`):
```xml
<uses-permission android:name="android.permission.CAMERA"/>
```

**iOS** (`ios/Runner/Info.plist`):
```xml
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to detect masks</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs photo library access to detect masks in images</string>
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^1.0.7      # Image selection from gallery
  tflite_v2: ^1.0.0         # TensorFlow Lite integration
  camera: ^0.10.5+9         # Camera functionality
  camera_web: ^0.3.2+4      # Web camera support
```

## Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Known Limitations

- Camera detection requires device with functional camera
- Model accuracy depends on image quality and lighting conditions
- Real-time detection performance varies by device capabilities

## Future Enhancements

- [ ] Multiple face detection in single image
- [ ] Detection history and statistics
- [ ] Model retraining interface
- [ ] Social distancing detection
- [ ] Export detection reports

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is available for educational and personal use.

## Acknowledgments

- TensorFlow Lite for mobile ML capabilities
- Flutter team for the excellent framework
- Background image and assets used in the application

## Support

For issues, questions, or suggestions, please open an issue in the repository.

---

**Stay Safe, Stay Covered: Smart Detection for Safer Spaces** 🎭
