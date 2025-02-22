import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class Controlla extends StatefulWidget {
  final Flutter3DController controller;
  final String label;
  final VoidCallback onClose;

  const Controlla({
    super.key,
    required this.controller,
    required this.label,
    required this.onClose,
  });

  @override
  ControllaState createState() => ControllaState();
}

class ControllaState extends State<Controlla> {
  double rotationY = 0.0;

  void _updateRotation(double newY) {
    setState(() {
      rotationY = newY;
    });
    widget.controller.setCameraOrbit(rotationY, 60, 0); 
  }

  final Map<String, int> animationDurations = {
    "dance": 6,  
    "pray": 6,
  };

  void _playAnimationForDuration(String animationName) async {
    widget.controller.playAnimation(animationName: animationName);
    await Future.delayed(Duration(seconds: animationDurations[animationName] ?? 8));
    widget.controller.stopAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey[900],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: widget.onClose,
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _controlButton(Icons.arrow_back, () => _updateRotation(rotationY - 20)),
              _controlButton(Icons.arrow_forward, () => _updateRotation(rotationY + 20)),
            ],
          ),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => _playAnimationForDuration(
              widget.label.contains("1") ? "dance" : "pray",
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.tealAccent[700],
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              widget.label.contains("1") ? "Dance" : "Pray",
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _controlButton(IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: Colors.blueGrey[800],
          shape: CircleBorder(),
          padding: EdgeInsets.all(12),
        ),
      ),
    );
  }
}