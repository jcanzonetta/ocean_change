class Activity {
  String name;
  bool? isDefault;

  Activity({required this.name, this.isDefault});

  factory Activity.fromFirestore(Map document) {
    return Activity(
        name: document['name'], isDefault: document['default'] ?? false);
  }
}
