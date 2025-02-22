import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:_3d_controlla/screens/decision_page.dart';

class ImportedModel extends StatefulWidget {
  const ImportedModel({super.key});

  @override
  State<ImportedModel> createState() => _ImportedModelState();
}

class _ImportedModelState extends State<ImportedModel> {
  String? modelPath;
  bool isLoading = false;
  bool hasAnimation = false;
  bool isPlaying = false;
  double zoomLevel = 2.0; 
  double panOffset = 0.0; 

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['glb'],
      withData: true,
    );

    if (result != null) {
      setState(() {
        isLoading = true;
      });

      if (kIsWeb) {
        Uint8List? modelBytes = result.files.first.bytes;
        if (modelBytes != null) {
          final base64String = base64Encode(modelBytes);
          modelPath = "data:model/glb;base64,$base64String";
        }
      } else {
        modelPath = result.files.first.path;
      }

      setState(() {
        isLoading = false;
        hasAnimation = true;
      });
    }
  }

  void _toggleAnimation() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DecisionPage()),
            );
          },
        ),
        title: Row(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('assets/image/controlla.png'),
            ),
            Text('IMPORTED 3D MODEL'),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueGrey.shade900, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : modelPath != null
                        ? ModelViewer(
                            src: modelPath!,
                            alt: "A 3D model",
                            ar: false,
                            autoRotate: isPlaying,
                            cameraControls: true,
                            cameraOrbit: "${panOffset}deg 75deg ${zoomLevel}m",
                          )
                        : const Text(
                            "Tap + to import a 3D model",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
              ),
            ),

            if (hasAnimation)
              Positioned(
                bottom: 120,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _toggleAnimation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
                      label: Text(isPlaying ? "Stop" : "Play"),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        heroTag: "import_model",
        onPressed: _pickFile,
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}