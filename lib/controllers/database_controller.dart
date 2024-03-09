import '../database/database_provider.dart';
import '../models/factor.dart';
import '../models/metric.dart';
import '../models/option.dart';
import '../models/selection.dart';
import '../models/software.dart';
import '../models/software_metric.dart';

///[_DatabaseController] clase que controla la base de datos
class _DatabaseController {
  ///[init] método que crea la base de datos
  void init() {
    DatabaseProvider.db.createDatabase();
  }

  ///[getSoftwares] método que retorna una lista de [Software]
  Future<List<Software>> getSoftwares() async {
    return DatabaseProvider.db.getSoftwares();
  }

  ///[getSoftwaresNames] método que retorna todos los nombres de softwares
  Future<List<String>> getSoftwaresNames() async {
    return DatabaseProvider.db.getSoftwaresNames();
  }

  ///[getSoftwareByName] método que retorna un [Software] dado su nombre
  Future<Software?> getSoftwareByName(String name) async {
    return DatabaseProvider.db.getSoftwareByName(name);
  }

  ///[getMetrics] método que retorna una lista de [Metric]
  Future<List<Metric>> getMetrics() async {
    return DatabaseProvider.db.getMetrics();
  }

  ///[getMetricsNames] método que retorna todos los nombres de metrics
  Future<List<String>> getMetricsNames() async {
    return DatabaseProvider.db.getMetricsNames();
  }

  ///[getMetricsNamesBySoftwareName] método que retorna todos los nombres de metrics dado un nombre de un software
  ///
  ///[softwareName] nombre del software que se le va a buscar los nombres de metrics
  Future<List<String>> getMetricsNamesBySoftwareName(
      String softwareName) async {
    return DatabaseProvider.db.getMetricsNamesBySoftwareName(softwareName);
  }

  ///[getMetricByName] método que retorna un [Metric] dado su nombre
  Future<Metric?> getMetricByName(String name) async {
    return DatabaseProvider.db.getMetricByName(name);
  }

  ///[getSoftwaresMetrics] método que retorna una lista de [SoftwareMetric]
  Future<List<SoftwareMetric>> getSoftwaresMetrics() async {
    return DatabaseProvider.db.getSoftwaresMetrics();
  }

  ///[getSoftwareMetric] método que retorna un [SoftwareMetric] dado un nombre de un [Software] y un nombre de un [Metric]
  Future<SoftwareMetric?> getSoftwareMetric(
      String softwareName, String metricName) async {
    return DatabaseProvider.db.getSoftwareMetric(softwareName, metricName);
  }

  ///[getSoftwaresMetricsBySoftwareName] método que retorna un [SoftwareMetric] dado un nombre de un [Software]
  Future<List<SoftwareMetric>> getSoftwaresMetricsBySoftwareName(
      String softwareName) async {
    return DatabaseProvider.db.getSoftwaresMetricsBySoftwareName(softwareName);
  }

  ///[getFactors] método que retorna una lista de [Factor]
  Future<List<Factor>> getFactors() async {
    return DatabaseProvider.db.getFactors();
  }

  ///[getFactorsNames] método que retorna todos los nombres de factors
  Future<List<String>> getFactorsNames() async {
    return DatabaseProvider.db.getFactorsNames();
  }

  ///[getFactorsByMetricName] método que retorna una lista de [Factor] dado un nombre de un [Metric]
  Future<List<Factor>> getFactorsByMetricName(String metricName) async {
    return DatabaseProvider.db.getFactorsByMetricName(metricName);
  }

  ///[getFactorByName] método que retorna un [Factor] dado su nombre
  Future<Factor?> getFactorByName(String name) async {
    return DatabaseProvider.db.getFactorByName(name);
  }

  ///[getOptions] método que retorna una lista de [Option]
  Future<List<Option>> getOptions() async {
    return DatabaseProvider.db.getOptions();
  }

  ///[getOptionsNames] método que retorna todos los nombres de options
  Future<List<String>> getOptionsNames() async {
    return DatabaseProvider.db.getOptionsNames();
  }

  ///[getOptionsByFactorName] método que retorna una lista de [Option] dado un nombre de un [Factor]
  Future<List<Option>> getOptionsByFactorName(String factorName) async {
    return DatabaseProvider.db.getOptionsByFactorName(factorName);
  }

  ///[getOptionByName] método que retorna un [Option] dado su nombre
  Future<Option?> getOptionByName(String name) async {
    return DatabaseProvider.db.getOptionByName(name);
  }

  ///[getSelection] método que retorna un [Selection] dado un nombre de un [Software], un nombre de un [Factor] y un nombre de un [Option]
  Future<Selection?> getSelection(
      String softwareName, String factorName, String optionName) async {
    return DatabaseProvider.db
        .getSelection(softwareName, factorName, optionName);
  }

  ///[getSelections] método que retorna una lista [Selection] dado un nombre de un [Software], un nombre de un [Factor] y un nombre de un [Option]
  Future<List<Selection>> getSelections(
      String softwareName, String factorName) async {
    return DatabaseProvider.db.getSelections(softwareName, factorName);
  }

  ///[rawQuery] método para ejecutar una consulta
  ///
  ///[query] consulta a ejecutar
  Future<List<Map<String, Object?>>?> rawQuery(String query) async {
    return DatabaseProvider.db.rawQuery(query);
  }

  ///[insertSoftware] método para insertar un [Software]
  ///
  ///[software] [Software] a insertar
  Future<Software?> insertSoftware(Software software) async {
    return DatabaseProvider.db.insertSoftware(software);
  }

  ///[insertMetric] método para insertar un [Metric]
  ///
  ///[metric] [Metric] a insertar
  Future<Metric?> insertMetric(Metric metric) async {
    return DatabaseProvider.db.insertMetric(metric);
  }

  ///[insertSoftwareMetric] método para insertar un [SoftwareMetric]
  ///
  ///[softwareMetric] [SoftwareMetric] a insertar
  Future<SoftwareMetric?> insertSoftwareMetric(
      SoftwareMetric softwareMetric) async {
    return DatabaseProvider.db.insertSoftwareMetric(softwareMetric);
  }

  ///[insertFactor] método para insertar un [Factor]
  ///
  ///[factor] [Factor] a insertar
  Future<Factor?> insertFactor(Factor factor) async {
    return DatabaseProvider.db.insertFactor(factor);
  }

  ///[insertOption] método para insertar un [Option]
  ///
  ///[option] [Option] a insertar
  Future<Option?> insertOption(Option option) async {
    return DatabaseProvider.db.insertOption(option);
  }

  ///[insertSelection] método para insertar un [Selection]
  ///
  ///[selection] [Selection] a insertar
  Future<Selection?> insertSelection(Selection selection) async {
    return DatabaseProvider.db.insertSelection(selection);
  }

  ///[deleteAllSoftwares] método para eliminar todos los softwares
  ///
  ///retorna [true] si los borra, y [false] si no
  Future<bool> deleteAllSoftwares() async {
    return DatabaseProvider.db.deleteAllSoftwares();
  }

  ///[deleteSoftware] método para eliminar un software
  ///
  ///[name] nombre del software a eliminar
  ///
  ///retorna [true] si la borra, y [false] si no
  Future<bool> deleteSoftware(String name) async {
    return DatabaseProvider.db.deleteSoftware(name);
  }

  ///[containSoftwareName] método para saber si existe este nombre de software en la base de datos
  ///
  ///[name] nombre a verificar
  ///
  ///retorna [true] cuando existe, y [false] si no
  Future<bool> containSoftwareName(String name) async {
    return DatabaseProvider.db.containSoftwareName(name);
  }

  ///[containMetricName] método para saber si existe este nombre de metric en la base de datos
  ///
  ///[name] nombre a verificar
  ///
  ///retorna [true] cuando existe, y [false] si no
  Future<bool> containMetricName(String name) async {
    return DatabaseProvider.db.containMetricName(name);
  }

  ///[containFactorName] método para saber si existe este nombre de factor en la base de datos
  ///
  ///[name] nombre a verificar
  ///
  ///retorna [true] cuando existe, y [false] si no
  Future<bool> containFactorName(String name) async {
    return DatabaseProvider.db.containFactorName(name);
  }

  ///[containOptionName] método para saber si existe este nombre de option en la base de datos
  ///
  ///[name] nombre a verificar
  ///
  ///retorna [true] cuando existe, y [false] si no
  Future<bool> containOptionName(String name) async {
    return DatabaseProvider.db.containOptionName(name);
  }

  ///[softwareToList] método que busca un software dado su nombre y lo retorna en un [List<Map<String, Map<int, List>>>]
  ///
  ///[softwareName] nombre del software
  ///
  ///retorna [true] cuando existe, y [false] si no
  Future<List<Map<String, Map<int, List>>>> softwareToList(
      String softwareName) async {
    return DatabaseProvider.db.softwareToList(softwareName);
  }

  ///[hasSoftwares] método que retorna [true] si hay softwares en la base de datos y [false] si no
  Future<bool> hasSoftwares() async {
    var softwares = await getSoftwares();
    return softwares.isNotEmpty;
  }
}

///[databaseController] instancia de [_DatabaseController] utilizada para acceder a la base de datos
final databaseController = _DatabaseController();
