import 'package:flutter/material.dart';
import '../services/data_service.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {

  List<Map<String, String>> get events => DataService.timeline;

  void addEvent() {
    TextEditingController timeController = TextEditingController();
    TextEditingController descController = TextEditingController();

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
                "Add Timeline Event",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: timeController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Time (e.g. 21:45)",
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: descController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Event Description",
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {

                  if (timeController.text.isNotEmpty &&
                      descController.text.isNotEmpty) {

                    setState(() {
                      DataService.addEvent(
                        "1", // temporary caseId
                        timeController.text,
                        descController.text,
                      );
                      setState(() {});
                    });
                  }

                  Navigator.pop(context);
                },
                child: const Text("Add Event"),
              )
            ],
          ),
        );
      },
    );
  }

  void deleteEvent(int index) {
    setState(() {
      DataService.timeline.removeAt(index);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF1F2732),

      appBar: AppBar(
        title: const Text("Timeline"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: events.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timeline, color: Colors.white30, size: 60),
            SizedBox(height: 10),
            Text(
              "No Events Added",
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: events.length,
        itemBuilder: (context, index) {

          final event = events[index];

          return GestureDetector(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: const Color(0xFF2B3441),
                  title: const Text(
                    "Delete Event?",
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        deleteEvent(index);
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

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Timeline line + dot
                Column(
                  children: [
                    Container(
                      width: 3,
                      height: 20,
                      color: Colors.blueAccent,
                    ),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 3,
                      height: 80,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),

                const SizedBox(width: 12),

                /// Event card
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: const Color(0xFF2B3441),
                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          event["time"]!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          event["desc"]!,
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: addEvent,
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}