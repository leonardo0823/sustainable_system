import '../models/software.dart';

Future<void> asyncFor(int index, int max, Future<void> Function(int) forBody) {
  if (index >= max) {
    return Future.value();
  }
  return forBody(index).then((_) => asyncFor(index + 1, max, forBody));
}

String getClasification(int value) {
  if (value >= 0 && value <= 8) {
    return 'No Sostenible';
  } else if (value >= 9 && value <= 20) {
    return 'Poco Sostenible';
  }
  return 'Sostenible';
}

List<String> getDataInsertQuery(
    {dynamic software = 'default',
    required List<Map<String, Map<dynamic, dynamic>>> list,
    required List<String> metrics}) {
  List<String> data = [
    "INSERT INTO Software(${software == 'default' ? 'name' : 'name, rating, points'}) VALUES (${software == 'default' ? "'default'" : "'${software.name}', '${software.rating}', ${software.points}"});\n"
  ];

  for (int i = 0; i < list.length; i++) {
    var factors = list[i].entries.toList();
    if (software == 'default') {
      data.add("INSERT INTO Metric(name) VALUES ('${metrics[i]}');");
    }
    data.add(
        "INSERT INTO SoftwareMetric(software_name, metric_name) VALUES ('${software == 'default' ? software : software.name}', '${metrics[i]}');");
    for (int j = 0; j < factors.length; j++) {
      var optsMap = factors[j].value;
      var options = optsMap.entries.toList();
      if (software == 'default') {
        data.add(
            "INSERT INTO Factor(name, metric_name) VALUES ('${factors[j].key}', '${metrics[i]}');");
      }
      for (int k = 0; k < options.length; k++) {
        if (software == 'default') {
          data.add(
              "INSERT INTO Option(name, factor_name) VALUES ('${options[k].value[0]}', '${factors[j].key}');");
        }
        data.add(
            "INSERT INTO Selection(software_name, factor_name, option_name, isSelected, value) VALUES ('${software == 'default' ? software : software.name}', '${factors[j].key}', '${options[k].value[0]}', ${options[k].value[1] ? 1 : 0}, ${options[k].key});");
      }
    }
  }
  return data;
}

List<String> getDataUpdateQuery(
    {required String newName,
    required Software software,
    required List<Map<String, Map<dynamic, dynamic>>> list,
    required List<String> metrics}) {
  List<String> data = [];

  for (int i = 0; i < list.length; i++) {
    var factors = list[i].entries.toList();
    for (int j = 0; j < factors.length; j++) {
      var optsMap = factors[j].value;
      var options = optsMap.entries.toList();
      for (int k = 0; k < options.length; k++) {
        data.add('''UPDATE Selection 
           SET isSelected = ${options[k].value[1] ? 1 : 0}
           WHERE software_name = '${software.name}' and factor_name = '${factors[j].key}' and option_name = '${options[k].value[0]}';
        ''');
      }
    }
  }
  data.add('''UPDATE Software 
           SET name = '$newName',
           rating = '${software.rating}', 
           points = ${software.points}
           WHERE name = '${software.name}';
        ''');
  return data;
}
