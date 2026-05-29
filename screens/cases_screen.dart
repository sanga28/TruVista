import 'package:flutter/material.dart';
import 'case_detail_screen.dart';

class CasesScreen extends StatefulWidget {
  const CasesScreen({super.key});

  @override
  State<CasesScreen> createState() => _CasesScreenState();
}

class _CasesScreenState extends State<CasesScreen> {

  List<Map<String, String>> cases = [
    {
      "title": "Downtown Incident",
      "evidence": "12",
      "scenes": "2",
      "update": "3h ago"
    }
  ];

  void openNewCaseSheet() {

    TextEditingController nameController = TextEditingController();
    TextEditingController locationController = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF17181C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {

        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const Text(
                "Create New Case",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Case Name",
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: locationController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Location",
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),

              const SizedBox(height: 25),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {

                  if (nameController.text.isNotEmpty) {
                    setState(() {
                      cases.add({
                        "title": nameController.text,
                        "evidence": "0",
                        "scenes": "0",
                        "update": "Just now"
                      });
                    });
                  }

                  Navigator.pop(context);
                },
                child: const Text("Create Case"),
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildCaseCard(Map<String, String> caseData) {

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CaseDetailScreen(
              caseData: caseData,   // 🔥 FIXED
            ),
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: const Color(0xFF1D1F24),
          borderRadius: BorderRadius.circular(20),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              caseData["title"]!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Text(
                  "Evidence: ${caseData["evidence"]}",
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(width: 20),
                Text(
                  "Scenes: ${caseData["scenes"]}",
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              "Updated: ${caseData["update"]}",
              style: const TextStyle(color: Colors.white38),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF1F2732),

      appBar: AppBar(
        title: const Text("Cases"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: cases.length,
          itemBuilder: (context, index) {
            return buildCaseCard(cases[index]);
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: openNewCaseSheet,
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}