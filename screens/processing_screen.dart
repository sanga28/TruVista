import 'package:flutter/material.dart';
import 'dart:async';
import 'scene/scene_3d_screen.dart';  // ✅ correct
import '../services/data_service.dart';

class ProcessingScreen extends StatefulWidget {
  final List images;

  const ProcessingScreen({super.key, required this.images});

  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen> {

  List<String> steps = [
    "Analyzing images...",
    "Generating point cloud...",
    "Creating textured room...",
    "Building 3D scene...",
  ];

  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    runSteps();
  }

  void runSteps() async {
    for (int i = 0; i < steps.length; i++) {
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        currentStep = i;
      });
    }


    DataService.saveGeneratedCase(
      title: "Generated Scene",
      desc: "${widget.images.length} images processed",
      videoPath: "assets/videos/scene.mp4",
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => Scene3DScreen(hasScene: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF1F2732),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const CircularProgressIndicator(),

            const SizedBox(height: 30),

            Text(
              steps[currentStep],
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}