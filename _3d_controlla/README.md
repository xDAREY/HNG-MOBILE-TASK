# 🚀 3D Controlla

## 🌍 Overview
3D Controlla is a Flutter-based application designed for rendering and interacting with 3D models. It enables users to upload and view `.glb` models, control the camera, and animate characters if supported. The application provides both preloaded models and the ability to import custom models for an immersive 3D experience. 🎮

## ✨ Features
- **📱 Splash Screen**: A welcoming screen with an app logo before transitioning to the main menu.
- **📌 Decision Page**: Allows users to choose between viewing preloaded models or importing their own.
- **🎭 Preloaded Models**: View and interact with built-in 3D models.
- **📂 Imported Models**: Upload `.glb` files from local storage and control animations.
- **🎮 3D Model Controls**:
  - 🔄 Move models left or right.
  - 🔍 Zoom in and out.
  - ▶️ Play or ⏹ Stop animations.
  - 🎥 Camera orbit control.
- **🌈 Smooth UI with a Gradient Background**.

## 🛠 Dependencies
The project relies on the following Flutter packages:
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  model_viewer_plus: ^1.9.1
  flutter_3d_controller: ^2.1.0
  vector_math: ^2.1.4
  file_picker: ^9.0.0
  path_provider: ^2.1.5

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/image/
    - assets/model/
```

## 📁 Project Structure
The project is structured as follows:
```
lib/
│-- main.dart
│-- screens/
│   │-- splash_screen.dart  # 🚀 App splash screen
│   │-- decision_page.dart  # 📌 Menu selection between imported or preloaded models
│   │-- imported_model_screen.dart  # 📂 Handles uploaded GLB models
│   │-- preloaded_model_screen.dart  # 🎭 Handles built-in models
│-- utils/
│   │-- controlla.dart  # 🎮 Provides UI controls for 3D interaction
assets/
│-- image/
│-- model/
```

## ⚙️ How It Works
### 1️⃣ Splash Screen
- Displays the app logo for 3 seconds before redirecting to the Decision Page. ⏳

### 2️⃣ Decision Page
- Provides options to either upload a `.glb` model or view preloaded 3D models.
- Two buttons allow navigation to different screens. 🔘

### 3️⃣ Preloaded Model Viewer
- Loads two predefined 3D models (`peasant_girl.glb` and `praying.glb`).
- Provides camera controls and animation playback. 🎥

### 4️⃣ Imported Model Viewer
- Users can upload `.glb` files via `file_picker`. 📂
- Supports auto-rotation, zooming, and animation control. 🔄
- If the model contains animations, a play/stop button is displayed. ▶️

### 5️⃣ Controls (`Controlla`)
- Allows movement and rotation of the 3D model. 🎮
- Plays predefined animations (`dance`, `pray`) for supported models. 🕺🙏

## ▶️ How to Run
1. Ensure you have Flutter installed. If not, install it from [Flutter's official site](https://flutter.dev/docs/get-started/install). 🔧
2. Clone the repository:
   ```sh
   git clone https://github.com/xDAREY/HNG-MOBILE-TASK/tree/main/_3d_controlla
   cd 3d-controlla
   ```
3. Get dependencies:
   ```sh
   flutter pub get
   ```
4. Run the app:
   ```sh
   flutter run
   ```

## 🚀 Future Improvements
- 📱 Improve UI responsiveness.
- 🎭 Add more preloaded 3D models.
- 🎬 Expand animation support with custom animation names from GLB files.
- ⚡ Optimize performance for large `.glb` models.

## 📜 License
This project is open-source and available under the MIT License. 📝

