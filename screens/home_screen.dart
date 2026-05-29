import 'package:flutter/material.dart';
import '../widgets/image_carousel.dart';
import '../services/data_service.dart';
import 'scene/scene_3d_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF1F2732),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Header
                const Text(
                  "Hello Investigator 👋",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 25),

                /// Carousel
                ImageCarousel(),

                const SizedBox(height: 30),

                /// Quick Actions
                const Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    buildAction(context, Icons.folder, "Cases",
                            () => Navigator.pushNamed(context, '/cases')),

                    buildAction(context, Icons.image, "Evidence",
                            () => Navigator.pushNamed(context, '/evidence')),

                    buildAction(context, Icons.timeline, "Timeline",
                            () => Navigator.pushNamed(context, '/timeline')),

                    buildAction(context, Icons.people, "People",
                            () => Navigator.pushNamed(context, '/people')),
                  ],
                ),

                const SizedBox(height: 30),

                /// Recent Cases
                const Text(
                  "Recent Cases",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                Column(
                  children: [

                    /// Latest Generated Case
                    if (DataService.latestCase != null)
                      buildCaseCard(context, DataService.latestCase!),

                    const SizedBox(height: 10),

                    /// Demo Case
                    buildCaseCard(context, DataService.demoCase),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Quick Action Button
  Widget buildAction(
      BuildContext context,
      IconData icon,
      String title,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,

      child: Column(
        children: [

          Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              color: Color(0xFF2B3441),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white),
          ),

          const SizedBox(height: 8),

          Text(
            title,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  /// 🔹 Case Card (FIXED)
  Widget buildCaseCard(
      BuildContext context,
      Map<String, dynamic> caseData,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Scene3DScreen(
              hasScene: true,
              videoPath: caseData["video"],
            ),
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: const Color(0xFF2B3441),
          borderRadius: BorderRadius.circular(18),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Title
            Text(
              caseData["title"],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            /// Description
            Text(
              caseData["desc"],
              style: const TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 10),

            /// Location + Investigator
            Row(
              children: [

                const Icon(Icons.location_on,
                    size: 14, color: Colors.white54),
                const SizedBox(width: 5),
                Text(caseData["location"],
                    style: const TextStyle(color: Colors.white54)),

                const SizedBox(width: 15),

                const Icon(Icons.person,
                    size: 14, color: Colors.white54),
                const SizedBox(width: 5),
                Text(caseData["investigator"],
                    style: const TextStyle(color: Colors.white54)),
              ],
            ),

            const SizedBox(height: 6),

            /// Time
            Text(
              caseData["time"],
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}