import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

///[preferences] instancia de [SharedPreferences] que va a contener las preferencias compartidas
///
///Se utiliza para controlar si un tutorial fue mostrado y no volverlo a mostrar más
SharedPreferences? preferences;

///[key_home] constante que contiene la clave de la pantalla home
const String key_home = 'home';

///[key_calculation] constante que contiene la clave de la pantalla de calcular
const String key_calculation = 'calculation';

///[key_history] constante que contiene la clave de la pantalla historial
const String key_history = 'view_history';

///[initPreferences] función que inicia las preferencias compartidas
Future initPreferences() async {
  preferences = await SharedPreferences.getInstance();
}

///[setShowDiscovery] función para cambiar el valor de un dato en las preferencias compartidas dado su clave
///
///[value] valor a cambiar
///
///[key] clave del dato a cambiar
Future setShowDiscovery(bool value, String key) async {
  await preferences!.setBool(key, value);
}

///[getShowDiscovery] retorna el valor [true] o [false] de un dato dado su clave y retorna [null] en caso de no existir ese dato
bool? getShowDiscovery(String key) => preferences!.getBool(key);

///[kFeatureId1PopupMenu] constante que contiene el id del [PopupMenuButton]
const kFeatureId1PopupMenu = 'feature_1PopupMenu';

///[kFeatureId2CalculateSoftware] constante que contiene el id del botón de calcular el software
const kFeatureId2CalculateSoftware = 'feature_2Calculate_software';

///[kFeatureId3History] constante que contiene el id del botón de historial
const kFeatureId3History = 'feature_3History';

///[kFeatureId4Settings] constante que contiene el id del botón de ajustes
const kFeatureId4Settings = 'feature_4Settings';

///[kFeatureId5Help] constante que contiene el id del boton de ayuda
const kFeatureId5Help = 'feature_5Help';

///[kFeatureId6SaveSoftware] constante que contiene el id del botón de guardar el software
const kFeatureId6SaveSoftware = 'feature_6Save_software';

///[kFeatureId7GeneratePDF] constante que contiene el id del botón de generar PDF
const kFeatureId7GeneratePDF = 'feature_7GeneratePDF';

///[kFeatureId8Points] constante que contiene el id del botón de puntos
const kFeatureId8Points = 'feature_8Points';

///[kFeatureId9Clasification] constante que contiene el id del botón de clasificación
const kFeatureId9Clasification = 'feature_9Clasification';

///[kFeatureId10Metric] constante que contiene el id del tabbar
const kFeatureId10Metric = 'feature_10Metric';

///[kFeatureId11MetricPoints] constante que contiene el id de los puntos de una metrica
const kFeatureId11MetricPoints = 'feature_11MetricPoints';

///[kFeatureId12Factor] constante que contiene el id del step
const kFeatureId12Factor = 'feature_12Factor';

///[kFeatureId13DeleteAllSoftwares] constante que contiene el id del botón eliminar todos los softwares
const kFeatureId13DeleteAllSoftwares = 'feature_13Delete_all_softwares';

///[kFeatureId14Software] constante que contiene el id del botón de software
const kFeatureId14Software = 'feature_14Software';

///[buildWidget] función para agregar un tutorial a un elemento de tipo [Widget] determinado de la aplicación
///
///[featureId] id del elemento que se le va a agregar el tutorial
///
///[tapTarget] elemento de tipo [Widget] que aparecerá marcado al salir el tutorial
///
///[child] elemento de tipo [Widget] que se le va a agregar el tutorial
///
///[title] título del tutorial(Opcional)
///
///[description] descripción del tutorial(Opcional)
///
///[contentLocation] localización del contenido del tutorial
DescribedFeatureOverlay buildWidget(BuildContext context,
    {required String featureId,
    required Widget tapTarget,
    required Widget child,
    String title = '',
    String description = '',
    Future<bool> Function()? onOpen,
    required ContentLocation contentLocation}) {
  return DescribedFeatureOverlay(
    featureId: featureId,
    tapTarget: tapTarget,
    title: Text(title),
    description: Text(
      description,
      style: TextStyle(color: Colors.black54),
    ),
    backgroundColor: primarySwatch[800],
    targetColor: primarySwatch[200]!,
    textColor: Colors.white,
    backgroundOpacity: 0.9,
    allowShowingDuplicate: true,
    contentLocation: contentLocation,
    barrierDismissible: false,
    child: child,
    onOpen: onOpen,
  );
}

///[showDiscovery] función encargada de mostrar el tutorial
///
///[context] contexto en el que va a estar
///
///[listId] lista de todos los id de los elementos que se van a mostrar en el tutorial
///
///[key] clave de la pantalla en la que se va a mostrar el tutorial
Future<void> showDiscovery(BuildContext context,
    {required List<String> listId, required String key}) async {
  await FeatureDiscovery.clearPreferences(
    context,
    listId,
  );
  FeatureDiscovery.discoverFeatures(
    context,
    listId,
  );
  setShowDiscovery(false, key);
}
