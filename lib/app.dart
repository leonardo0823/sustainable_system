import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/database_controller.dart';
import 'screens/home_page.dart';
import 'utils/constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    databaseController.init(); //Iniciando la base de datos
    return FeatureDiscovery(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sistema Sostenible',
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: primarySwatch[300],
          primarySwatch: primarySwatch,
        ),
        home: const HomePage(),
      ),
    );
  }
}
