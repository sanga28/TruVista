import 'dart:io';
import 'package:flutter/material.dart';

class EvidenceTile extends StatelessWidget {

  final File image;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const EvidenceTile({
    super.key,
    required this.image,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,

      onLongPress: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: const Color(0xFF2B3441),
            title: const Text(
              "Delete Evidence?",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  onDelete();
                  Navigator.pop(context);
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },

      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.file(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}