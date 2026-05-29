import 'package:flutter/material.dart';
import 'evidence_screen.dart';
import 'people_screen.dart';
import 'timeline_screen.dart';
import 'scene/scene_3d_screen.dart';

class CaseDetailScreen extends StatelessWidget {

  final Map<String, String> caseData;

  const CaseDetailScreen({
    super.key,
    required this.caseData,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF1F2732),

      appBar: AppBar(
        title: Text(caseData["title"]!),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,

          children: [

            DashboardTile(
              icon: Icons.image,
              title: "Evidence",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EvidenceScreen(),
                  ),
                );
              },
            ),

            DashboardTile(
              icon: Icons.view_in_ar,
              title: "Scenes",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Scene3DScreen(hasScene: false),
                  ),
                ); // 🔥 3D
              },
            ),

            DashboardTile(
              icon: Icons.timeline,
              title: "Timeline",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TimelineScreen(),
                  ),
                );
              },
            ),

            DashboardTile(
              icon: Icons.people,
              title: "People",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PeopleScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardTile extends StatelessWidget {

  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const DashboardTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,

      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2B3441),
          borderRadius: BorderRadius.circular(18),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 10),

            Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}