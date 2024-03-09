import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final path = (await getExternalStorageDirectory())!.path;
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  await OpenFilex.open('$path/$fileName');
}

Future<Uint8List> readImageData(String name) async {
  final data = await rootBundle.load('assets/images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
