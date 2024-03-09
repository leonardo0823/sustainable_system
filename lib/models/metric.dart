class Metric {
  late String name;

  Metric({required this.name});

  Metric.fromMap(Map<String, dynamic> map) {
    name = map['name'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  @override
  String toString() => 'Metric(name: $name)';
}
