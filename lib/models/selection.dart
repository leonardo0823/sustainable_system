class Selection {
  late String factor_name;
  late String software_name;
  late String option_name;
  late bool isSelected;
  late int value;

  Selection({
    required this.software_name,
    required this.factor_name,
    required this.option_name,
    required this.isSelected,
    required this.value,
  });

  Selection.fromMap(Map<String, dynamic> map) {
    software_name = map['software_name'];
    factor_name = map['factor_name'];
    option_name = map['option_name'];
    isSelected = map['isSelected'] == 0 ? false : true;
    value = map['value'];
  }

  Map<String, dynamic> toMap() {
    return {
      'software_name': software_name,
      'factor_name': factor_name,
      'option_name': option_name,
      'isSelected': isSelected ? 1 : 0,
      'value': value,
    };
  }

  @override
  String toString() =>
      'Selection(software_name: $software_name, factor_name: $factor_name, option_name: $option_name, isSelected: $isSelected, value: $value)';
}
