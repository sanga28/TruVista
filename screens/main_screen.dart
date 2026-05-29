import 'package:flutter/material.dart';

// Import your real screens
import 'home_screen.dart';
import 'cases_screen.dart';
import 'evidence_screen.dart';
import 'timeline_screen.dart';
import 'people_screen.dart';
import 'scene/scene_3d_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),          // Home
    EvidenceScreen(),      // Evidence
  Scene3DScreen(hasScene: false),       // 3D (optional but shown here)
    TimelineScreen(),      // Timeline
    PeopleScreen(),        // People
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color(0xFF2B3441),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 20,
            )
          ],
        ),

        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: currentIndex,

          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.white54,
          type: BottomNavigationBarType.fixed,

          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.image),
              label: "Evidence",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.view_in_ar),
              label: "Scenes",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timeline),
              label: "Timeline",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "People",
            ),
          ],
        ),
      ),
    );
  }
}