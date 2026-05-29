import 'package:flutter/material.dart';
import '../services/subscription_service.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Upgrade")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "TruVista Pro",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            const Text("✔ Unlimited Cases"),
            const Text("✔ 3D Scene Reconstruction"),
            const Text("✔ Full Timeline Analysis"),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                SubscriptionService.activatePremium(days: 30);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Premium Activated")),
                );

                Navigator.pop(context);
              },
              child: const Text("Activate"),
            )
          ],
        ),
      ),
    );
  }
}