// health_event.dart
class HealthEvent {
  final String title;
  final DateTime date;
  final String time;
  final String location;
  final String description;
  final String? url; // Optional link for more info

  HealthEvent({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    this.url,
  });
}
