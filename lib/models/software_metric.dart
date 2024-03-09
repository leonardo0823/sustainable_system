class SoftwareMetric {
  late String software_name;
  late String metric_name;

  SoftwareMetric({required this.software_name, required this.metric_name});

  SoftwareMetric.fromMap(Map<String, dynamic> map) {
    software_name = map['software_name'];
    metric_name = map['metric_name'];
  }

  Map<String, dynamic> toMap() {
    return {
      'software_name': software_name,
      'metric_name': metric_name,
    };
  }

  @override
  String toString() =>
      'SoftwareMetric(software_name: $software_name, metric_name: $metric_name)';
}
