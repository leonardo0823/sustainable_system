import 'package:animate_do/animate_do.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../components/header.dart';
import '../components/my_button.dart';
import '../controllers/database_controller.dart';
import '../utils/constants.dart';
import '../utils/features_discoveries.dart';
import 'calculation_page.dart';
import 'history_page.dart';

class ButtonItem {
  final IconData icon;
  final String text;
  final Color color1;
  final Color color2;
  final void Function() onPress;
  ButtonItem(
      {required this.icon,
      required this.text,
      required this.color1,
      required this.color2,
      required this.onPress});
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BuildContext cont;
  List<GlobalKey<EnsureVisibleState>> ensureVisibleGlobalKey = [
    GlobalKey<EnsureVisibleState>(),
    GlobalKey<EnsureVisibleState>(),
    GlobalKey<EnsureVisibleState>(),
    GlobalKey<EnsureVisibleState>()
  ];
  @override
  void initState() {
    if (getShowDiscovery(key_home) ?? true) {
      SchedulerBinding.instance.addPostFrameCallback(
        (Duration duration) => showDiscovery(cont,
            listId: [
              kFeatureId1PopupMenu,
              kFeatureId2CalculateSoftware,
              kFeatureId3History,
              kFeatureId4Settings,
              kFeatureId5Help
            ],
            key: key_home),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      cont = context;
    });
    final features = [
      kFeatureId2CalculateSoftware,
      kFeatureId3History,
      kFeatureId4Settings,
      kFeatureId5Help
    ];
    final items = [
      ButtonItem(
        icon: FontAwesomeIcons.calculator,
        text: 'Calcular',
        color1: const Color(0xF4089556),
        color2: const Color(0xFF66BB6A),
        onPress: () async {
          var metrics = await databaseController.softwareToList('default');
          var metricsNames =
              await databaseController.getMetricsNamesBySoftwareName('default');
          Get.offAll(
            () => SlideInRight(
              duration: const Duration(milliseconds: 250),
              child: CalculationPage(
                softwareName: 'default',
                metrics: metrics,
                metricsNames: metricsNames,
              ),
            ),
          );
        },
      ),
      ButtonItem(
        icon: FontAwesomeIcons.clockRotateLeft,
        text: 'Historial',
        color1: const Color(0xF4085195),
        color2: const Color(0xFF1D8DE9),
        onPress: () {
          Get.offAll(
            () => SlideInRight(
              duration: const Duration(milliseconds: 250),
              child: HistoryPage(),
            ),
          );
        },
      ),
      ButtonItem(
        icon: FontAwesomeIcons.gear,
        text: 'Ajustes',
        color1: const Color(0xFF607D8B),
        color2: const Color(0xFF9E9E9E),
        onPress: () {
          _showDialogSettings(context);
        },
      ),
      ButtonItem(
        icon: FontAwesomeIcons.circleInfo,
        text: 'Acerca de',
        color1: Colors.black38,
        color2: Colors.grey,
        onPress: () {
          showAboutDialog(
            context: context,
            applicationName: 'Sistema Sostenible',
            applicationVersion: '1.0.0',
            applicationIcon: Image.asset(
              'assets/images/icon.png',
              scale: 5,
            ),
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                        child: Text(
                      'Autores:',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    )),
                    WidgetSpan(
                      child: Text(
                        'Leonardo Alain Moreira Rodríguez\nAlexis Manuel Hurtado García',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                        child: Text(
                      'Tutora: ',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    )),
                    WidgetSpan(
                      child: Text(
                        'MsC. Dailyn Sosa López',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    ];

    List<Widget> itemsMap = items
        .asMap()
        .entries
        .toList()
        .map(
          (itemMap) => FadeInLeft(
            duration: const Duration(milliseconds: 500),
            child: buildWidget(context,
                child: EnsureVisible(
                  key: ensureVisibleGlobalKey[itemMap.key],
                  child: MyButton(
                    icon: itemMap.value.icon,
                    child: Text(itemMap.value.text,
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    onPress: itemMap.value.onPress,
                    color1: itemMap.value.color1,
                    color2: itemMap.value.color2,
                  ),
                ),
                featureId: features[itemMap.key],
                tapTarget: FaIcon(itemMap.value.icon),
                contentLocation: ContentLocation.above, onOpen: () async {
              WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
                ensureVisibleGlobalKey[itemMap.key]
                    .currentState!
                    .ensureVisible();
              });
              return true;
            },
                title: '${itemMap.value.text}',
                description:
                    'Pulse aquí para abrir la pantalla ${itemMap.value.text}${itemMap.value.text == 'Ajustes' ? '(En desarrollo)' : ''}'),
          ),
        )
        .toList();
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 180),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 80),
                  ...itemsMap,
                ],
              ),
            ),
            const _Header(),
          ],
        ),
      ),
    );
  }

  void _showDialogSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Text(
                    'En desarrollo...',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FaIcon iconMenu = const FaIcon(
      FontAwesomeIcons.ellipsisVertical,
      color: Colors.white,
    );
    return Stack(
      children: [
        const IconHeader(
          icon: FontAwesomeIcons.house,
          title: 'Sistema Sostenible',
          subtitle: 'Menú',
        ),
        Positioned(
            right: 0,
            top: 45,
            child: buildWidget(
              context,
              title: 'Menú de Opciones',
              description: 'Pulse aquí para abril el Menú de Opciones',
              featureId: kFeatureId1PopupMenu,
              tapTarget: iconMenu,
              contentLocation: ContentLocation.below,
              child: PopupMenuButton(
                padding: const EdgeInsets.all(15),
                color: Colors.white,
                splashRadius: 5,
                shape: Border.all(width: 1, color: primarySwatch[900]!),
                icon: iconMenu,
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 1,
                    child: Text('Reiniciar tutoriales'),
                  ),
                ],
                onSelected: (value) {
                  if (value == 1) {
                    setShowDiscovery(true, key_home);
                    setShowDiscovery(true, key_calculation);
                    setShowDiscovery(true, key_history);

                    Get.offAll(() => HomePage());
                  }
                },
              ),
            ))
      ],
    );
  }
}
