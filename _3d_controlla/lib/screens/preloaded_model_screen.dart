import 'package:_3d_controlla/screens/decision_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:_3d_controlla/utils/controlla.dart';

class PreloadedModel extends StatefulWidget {
  const PreloadedModel({super.key});

  @override
  PreloadedModelState createState() => PreloadedModelState();
}

class PreloadedModelState extends State<PreloadedModel> {
  late Flutter3DController model1Controller;
  late Flutter3DController model2Controller;
  int? selectedController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    model1Controller = Flutter3DController();
    model2Controller = Flutter3DController();

    model1Controller.onModelLoaded = ValueNotifier<bool>(false);
    model2Controller.onModelLoaded = ValueNotifier<bool>(false);

    model1Controller.onModelLoaded.addListener(() {
      if (model1Controller.onModelLoaded.value) {
        _onModel1Loaded();
      }
    });

    model2Controller.onModelLoaded.addListener(() {
      if (model2Controller.onModelLoaded.value) {
        _onModel2Loaded();
      }
    });
  }

  void _onModel1Loaded() {
    setState(() {
      isLoading = false;
    });
    model1Controller.setCameraOrbit(-70, 50, 0);
  }

  void _onModel2Loaded() {
    setState(() {
      isLoading = false;
    });
    model2Controller.setCameraOrbit(70, 50, 0);
  }

  void _selectController(int controllerIndex) {
    setState(() {
      selectedController = controllerIndex;
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
            Text('PRELOADED'),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade900, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            if (isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
            Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Flutter3DViewer(
                          controller: model1Controller,
                          src: 'assets/model/peasant_girl.glb',
                        ),
                      ),
                      Expanded(
                        child: Flutter3DViewer(
                          controller: model2Controller,
                          src: 'assets/model/praying.glb',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (selectedController != null)
              Positioned(
                bottom: 80,
                left: 20,
                right: 20,
                child: Controlla(
                  controller: selectedController == 1
                      ? model1Controller
                      : model2Controller,
                  label:
                      selectedController == 1 ? "Character 1" : "Character 2",
                  onClose: () {
                    setState(() {
                      selectedController = null;
                    });
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showControllerSelectionDialog(),
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.sports_esports, color: Colors.white),
      ),
    );
  }

  void _showControllerSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text("Choose a Character",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.sports_esports,
                        size: 50, color: Colors.blue),
                    onPressed: () {
                      Navigator.pop(context);
                      _selectController(1);
                    },
                  ),
                  Text("Model 1",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon:
                        Icon(Icons.sports_esports, size: 50, color: Colors.red),
                    onPressed: () {
                      Navigator.pop(context);
                      _selectController(2);
                    },
                  ),
                  Text("Model 2",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
