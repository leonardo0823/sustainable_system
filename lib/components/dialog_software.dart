import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/database_controller.dart';
import '../models/software.dart';
import '../screens/history_page.dart';
import '../screens/home_page.dart';
import '../utils/functions.dart';

// ignore: must_be_immutable
class DialogSoftwareWidget extends StatefulWidget {
  String softwareName;
  String? rating;
  int? points;
  Widget? page;
  late List<Map<String, Map<int, List>>> metrics;
  List<String> metricsNames;

  DialogSoftwareWidget(
      {this.page,
      required this.metricsNames,
      required this.metrics,
      this.softwareName = 'default',
      this.rating,
      this.points,
      Key? key})
      : super(key: key);

  @override
  State<DialogSoftwareWidget> createState() => _DialogSoftwareWidgetState();
}

class _DialogSoftwareWidgetState extends State<DialogSoftwareWidget> {
  final _formKey = GlobalKey<FormState>();
  String? _textAddSoftwareName;

  late bool _existSoftwareName;

  bool _editing = false;
  @override
  void initState() {
    super.initState();

    if (widget.softwareName == 'default') {
      _existSoftwareName = false;
      _textAddSoftwareName = '';
    } else {
      _existSoftwareName = true;

      _textAddSoftwareName = widget.softwareName;
      _editing = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "${(_editing) ? "Editar" : "Agregar"} Software",
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _textAddSoftwareName,
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                          labelStyle: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color),
                        ),
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                        onSaved: (newValue) {
                          _textAddSoftwareName = newValue!;
                        },
                        onChanged: containSofwareName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Llene este campo';
                          }
                          if (value == 'default') {
                            return 'Este nombre de software no esta disponible';
                          }

                          if (_existSoftwareName) {
                            if ((!_editing) ||
                                (_editing && value != widget.softwareName)) {
                              return 'Este software ya existe';
                            }
                          }

                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          if (_editing) {
                            await _updateSoftware(_textAddSoftwareName!);
                          } else {
                            await _addSoftware(_textAddSoftwareName!);
                          }

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(
                                  "Software ${(_editing) ? "modificado" : "añadido"} satisfactoriamente")));

                          Get.offAll(() =>
                              _editing ? HistoryPage() : const HomePage());
                        }
                      },
                      child: Text(
                        widget.softwareName == 'default' ? 'Aceptar' : 'Editar',
                        style: const TextStyle(fontSize: 18),
                      )),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
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
    );
  }

  Future<void> _addSoftware(String name) async {
    var queries = getDataInsertQuery(
        software: Software(
            name: name, rating: widget.rating!, points: widget.points!),
        list: widget.metrics,
        metrics: widget.metricsNames);
    for (var query in queries) {
      await databaseController.rawQuery(query);
    }
  }

  Future<void> _updateSoftware(String name) async {
    var queries = getDataUpdateQuery(
        newName: name,
        software: Software(
            name: widget.softwareName,
            rating: widget.rating!,
            points: widget.points!),
        list: widget.metrics,
        metrics: widget.metricsNames);
    for (var query in queries) {
      await databaseController.rawQuery(query);
    }
  }

  void containSofwareName(String softwareName) async {
    _existSoftwareName = await databaseController
        .containSoftwareName(softwareName.toLowerCase());
  }
}
