import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StepContent extends StatefulWidget {
  Map<int, List> stepMap;
  int value;
  void Function(Map<int, List>) onChange;

  StepContent(
      {Key? key, required this.stepMap, required this.onChange, this.value = 0})
      : super(key: key);

  @override
  State<StepContent> createState() => _StepContentState();
}

class _StepContentState extends State<StepContent> {
  late int _radioValue;

  @override
  void initState() {
    super.initState();
    _radioValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
              color: Colors.black26,
              offset: Offset(1, 5),
              spreadRadius: 1,
              blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 10, 15),
            child: Column(
                children: widget.stepMap.entries
                    .toList()
                    .map(
                      (e) => RadioListTile<int>(
                        title: Text(
                          e.value[0],
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Text('${e.key} puntos'),
                        value: e.key,
                        groupValue: _radioValue,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _radioValue = value;
                              widget.value = value;
                            });
                            var m = widget.stepMap;
                            for (var e in m.entries) {
                              m[e.key]![1] = false;
                            }
                            m[value]![1] = true;
                            widget.onChange(m);
                          }
                        },
                      ),
                    )
                    .toList()),
          ),
        ),
      ),
    );
  }
}
