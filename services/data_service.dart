class DataService {

  /// 🔥 Latest generated case (dynamic)
  static Map<String, dynamic>? latestCase;

  static final Map<String, dynamic> demoCase = {
    "title": "Demo Case",
    "desc": "Preloaded Scene",
    "video": "assets/videos/scene2.mp4",
    "location": "Mumbai",
    "investigator": "Rumani Monisha",
    "time": "10:30 PM",
  };

  static void saveGeneratedCase({
    required String title,
    required String desc,
    required String videoPath,
  }) {
    latestCase = {
      "title": title,
      "desc": desc,
      "video": videoPath,
      "location": "Kolkata", // you can randomize later
      "investigator": "Sanga Anamika",
      "time": DateTime.now().toString().substring(0, 16),
    };
  }

  /// ---------------- CASES ----------------
  static List<Map<String, String>> cases = [
    {
      "id": "1",
      "title": "Downtown Incident",
      "location": "City Center",
      "update": "3h ago"
    }
  ];

  static void addCase(String title, String location) {
    cases.add({
      "id": DateTime.now().toString(),
      "title": title,
      "location": location,
      "update": "Just now",
    });
  }

  /// ---------------- EVIDENCE ----------------
  static List<Map<String, dynamic>> evidence = [];

  static void addEvidence(String caseId, String imagePath) {
    evidence.add({
      "id": DateTime.now().toString(),
      "caseId": caseId,
      "image": imagePath,
    });
  }

  static List<Map<String, dynamic>> getEvidence(String caseId) {
    return evidence.where((e) => e["caseId"] == caseId).toList();
  }

  /// ---------------- PEOPLE ----------------
  static List<Map<String, String>> people = [];

  static void addPerson(String caseId, String name, String role) {
    people.add({
      "id": DateTime.now().toString(),
      "caseId": caseId,
      "name": name,
      "role": role,
    });
  }

  static List<Map<String, String>> getPeople(String caseId) {
    return people.where((p) => p["caseId"] == caseId).toList();
  }

  /// ---------------- TIMELINE ----------------
  static List<Map<String, String>> timeline = [];

  static void addEvent(String caseId, String time, String desc) {
    timeline.add({
      "id": DateTime.now().toString(),
      "caseId": caseId,
      "time": time,
      "desc": desc,
    });
  }

  static List<Map<String, String>> getEvents(String caseId) {
    return timeline.where((t) => t["caseId"] == caseId).toList();
  }

}
