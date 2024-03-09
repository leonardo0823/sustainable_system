class Option {
  late String name;
  late String factor_name;

  Option({
    required this.name,
    required this.factor_name,
  });

  Option.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    factor_name = map['factor_name'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'factor_name': factor_name,
    };
  }

  @override
  String toString() => 'Option(name: $name, factor_name: $factor_name)';
}
