import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'processing_screen.dart';
import '../services/subscription_service.dart';
import 'subscription_screen.dart';

class EvidenceScreen extends StatefulWidget {
  const EvidenceScreen({super.key});

  @override
  State<EvidenceScreen> createState() => _EvidenceScreenState();
}

class _EvidenceScreenState extends State<EvidenceScreen> {

  final ImagePicker picker = ImagePicker();
  List<File> evidenceImages = [];

  /// 🔹 PICK IMAGES (with limit check)
  Future<void> pickImages() async {

    if (!SubscriptionService.isActive && evidenceImages.length >= 5) {
      showUpgradeDialog("Upgrade to add more evidence");
      return;
    }

    final List<XFile> images = await picker.pickMultiImage();

    if (images.isNotEmpty) {
      setState(() {
        evidenceImages.addAll(images.map((e) => File(e.path)));
      });
    }
  }

  /// 🔹 START RECONSTRUCTION
  void startReconstruction() {

    if (evidenceImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Add evidence first")),
      );
      return;
    }

    /// 🔴 Premium check
    if (!SubscriptionService.isActive) {
      showUpgradeDialog("Upgrade to generate 3D reconstruction");
      return;
    }

    /// ✅ Proceed
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProcessingScreen(images: evidenceImages),
      ),
    );
  }

  /// 🔥 COMMON UPGRADE DIALOG
  void showUpgradeDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Premium Feature"),
        content: Text(message),
        actions: [

          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),

          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SubscriptionScreen(),
                ),
              );
            },
            child: const Text("Upgrade"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF1F2732),

      appBar: AppBar(
        title: const Text("Evidence"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            /// Instruction
            const Text(
              "Select 15–20 images for better reconstruction",
              style: TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 15),

            /// Image Grid
            Expanded(
              child: evidenceImages.isEmpty
                  ? const Center(
                child: Text(
                  "No Evidence Selected",
                  style: TextStyle(color: Colors.white54),
                ),
              )
                  : GridView.builder(
                itemCount: evidenceImages.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return Image.file(
                    evidenceImages[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            /// Buttons
            Row(
              children: [

                Expanded(
                  child: ElevatedButton(
                    onPressed: pickImages,
                    child: const Text("Add Images"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: startReconstruction,
                    child: const Text("Generate Scene"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}