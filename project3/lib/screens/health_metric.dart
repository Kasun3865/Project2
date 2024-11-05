// health_metric.dart
class HealthMetric {
  final String type; // Type of metric (e.g., weight, blood pressure, glucose)
  final double value; // Value of the metric
  final DateTime date; // Date of the entry

  HealthMetric({required this.type, required this.value, required this.date});
}
