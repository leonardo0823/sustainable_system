import 'package:animate_do/animate_do.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../components/my_button.dart';
import '../controllers/database_controller.dart';
import '../models/software.dart';
import '../utils/features_discoveries.dart';
import 'calculation_page.dart';
import 'home_page.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool hasSoftwares = false;
  @override
  void initState() {
    super.initState();
    loadState();
  }

  void loadState() async {
    var checkHasSoftwares = await databaseController.hasSoftwares();
    setState(() {
      hasSoftwares = checkHasSoftwares;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (getShowDiscovery(key_history) ?? true && hasSoftwares) {
      SchedulerBinding.instance.addPostFrameCallback((Duration duration) =>
          showDiscovery(context,
              listId: [kFeatureId13DeleteAllSoftwares, kFeatureId14Software],
              key: key_history));
    }

    FaIcon iconDelete = const FaIcon(FontAwesomeIcons.trash);
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        Get.offAll(
          () => SlideInLeft(
            duration: const Duration(milliseconds: 250),
            child: const HomePage(),
          ),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF0777D2),
          title: const Text(
            'Historial',
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            if (hasSoftwares)
              buildWidget(
                context,
                child: IconButton(
                  onPressed: () async {
                    _showDialogDeleteAllSoftwares(context);
                  },
                  icon: iconDelete,
                ),
                featureId: kFeatureId13DeleteAllSoftwares,
                tapTarget: iconDelete,
                contentLocation: ContentLocation.below,
                title: 'Eliminar',
                description: 'Pulse aquí si desea eliminar todos los softwares',
              ),
          ],
          leading: IconButton(
            onPressed: () => Get.offAll(
              () => SlideInLeft(
                duration: const Duration(milliseconds: 250),
                child: const HomePage(),
              ),
            ),
            icon: const FaIcon(FontAwesomeIcons.chevronLeft),
          ),
        ),
        body: FutureBuilder<List<Software>>(
          future: databaseController.getSoftwares(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Software>? list = snapshot.data;
              if (list!.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        FaIcon(
                          FontAwesomeIcons.circleInfo,
                          size: 120,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'No hay historial de software',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                );
              }

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  Software? software = list[index];
                  return (index == 0)
                      ? buildWidget(context,
                          featureId: kFeatureId14Software,
                          tapTarget:
                              FaIcon(FontAwesomeIcons.solidWindowMaximize),
                          child: _buildButton(context, software),
                          contentLocation: ContentLocation.below,
                          title: 'Software',
                          description:
                              'Pulsa aquí para editar el software o \nMantén pulsado para eliminarlo')
                      : _buildButton(context, software);
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  FadeInDown _buildButton(BuildContext context, Software software) {
    return FadeInDown(
      duration: const Duration(milliseconds: 500),
      child: MyButton(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${software.name}',
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.left,
            ),
            Text(
              '${software.rating}\n${software.points} puntos',
              style: TextStyle(color: Colors.white70, fontSize: 14),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        color1: const Color(0xFF0777D2),
        color2: const Color(0xFF3B9BE9),
        onPress: () async {
          var metrics = await databaseController.softwareToList(software.name);
          var metricsNames = await databaseController
              .getMetricsNamesBySoftwareName(software.name);
          Get.offAll(
            () => SlideInRight(
              duration: const Duration(milliseconds: 250),
              child: CalculationPage(
                softwareName: software.name,
                metrics: metrics,
                metricsNames: metricsNames,
              ),
            ),
          );
        },
        onLongPress: () async {
          _showDialogDeleteSoftware(context, software);
        },
        icon: FontAwesomeIcons.solidWindowMaximize,
      ),
    );
  }

  void _showDialogDeleteSoftware(
      BuildContext context, Software software) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.white,
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
                  alignment: Alignment.center,
                  child: Text(
                    '¿Desea eliminar el software ${software.name}?',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                        onPressed: () async {
                          bool isDeleted = await databaseController
                              .deleteSoftware(software.name);
                          if (isDeleted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                        'Software eliminado satisfactoriamente')));
                            Get.offAll(() => HistoryPage());
                          }
                        },
                        child: const Text(
                          'Aceptar',
                          style: TextStyle(fontSize: 18),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(fontSize: 18),
                        ))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showDialogDeleteAllSoftwares(BuildContext context) async {
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
                    '¿Desea eliminar todos los softwares?',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await databaseController.deleteAllSoftwares();

                        Get.offAll(() => HistoryPage());
                      },
                      child: const Text(
                        'Aceptar',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                  mainAxisSize: MainAxisSize.min,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
