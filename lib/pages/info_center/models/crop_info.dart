class CropInfo {
  final String name;
  final String image;
  final String description;
  final Map<String, String> quickFacts;
  final List<Map<String, String>> schedule;
  final List<String> gettingStarted;
  final List<Map<String, String>> pests;

  CropInfo({
    required this.name,
    required this.image,
    required this.description,
    required this.quickFacts,
    required this.schedule,
    required this.gettingStarted,
    required this.pests,
  });
}
