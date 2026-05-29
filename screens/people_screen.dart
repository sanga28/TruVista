import 'package:flutter/material.dart';
import '../services/data_service.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({super.key});

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {

  List<Map<String, String>> get people => DataService.people;

  void addPerson() {
    TextEditingController nameController = TextEditingController();
    String role = "Witness";

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2B3441),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const Text(
                "Add Person",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),

              const SizedBox(height: 15),

              DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF2B3441),
                value: role,
                style: const TextStyle(color: Colors.white),

                items: const [
                  DropdownMenuItem(value: "Witness", child: Text("Witness")),
                  DropdownMenuItem(value: "Victim", child: Text("Victim")),
                  DropdownMenuItem(value: "Suspect", child: Text("Suspect")),
                  DropdownMenuItem(value: "Officer", child: Text("Officer")),
                ],

                onChanged: (value) {
                  role = value!;
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {

                  if (nameController.text.isNotEmpty) {
                    setState(() {
                      DataService.addPerson(
                        "1", // temporary caseId
                        nameController.text,
                        role,
                      );
                      setState(() {});
                    });
                  }

                  Navigator.pop(context);
                },

                child: const Text("Add Person"),
              )
            ],
          ),
        );
      },
    );
  }

  void deletePerson(int index) {
    setState(() {
      DataService.people.removeAt(index);
      setState(() {});
    });
  }

  Color getRoleColor(String role) {
    switch (role) {
      case "Suspect":
        return Colors.redAccent;
      case "Victim":
        return Colors.orangeAccent;
      case "Officer":
        return Colors.blueAccent;
      default:
        return Colors.greenAccent;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF1F2732),

      appBar: AppBar(
        title: const Text("People"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: people.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people, color: Colors.white30, size: 60),
            SizedBox(height: 10),
            Text(
              "No People Added",
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: people.length,
        itemBuilder: (context, index) {

          final person = people[index];

          return GestureDetector(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: const Color(0xFF2B3441),
                  title: const Text(
                    "Remove Person?",
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        deletePerson(index);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Remove",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },

            child: Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: const Color(0xFF2B3441),
                borderRadius: BorderRadius.circular(16),
              ),

              child: Row(
                children: [

                  /// Avatar circle
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: getRoleColor(person["role"]!),
                    child: Text(
                      person["name"]![0],
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),

                  const SizedBox(width: 14),

                  /// Name + role
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          person["name"]!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          person["role"]!,
                          style: TextStyle(
                            color: getRoleColor(person["role"]!),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: addPerson,
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}