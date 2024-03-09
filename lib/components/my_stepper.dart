import 'package:flutter/material.dart';
import 'step_content.dart';

// ignore: must_be_immutable
class MyStepper extends StatefulWidget {
  List<Step> steps;
  StepperType type;
  int? currentStep;
  int value = 0;
  bool isSave = false;

  void Function(int)? onStepTapped;

  MyStepper(
      {Key? key,
      required this.steps,
      this.type = StepperType.vertical,
      this.onStepTapped})
      : super(key: key);

  @override
  State<MyStepper> createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {
  late int _currentStep;
  // ignore: unused_field
  late List<int> _values;

  void setValues() {
    List<int> values = [];
    for (var element in widget.steps) {
      var step = element.content as StepContent;
      values.add(step.value);
    }
    setState(() {
      _values = values;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentStep = widget.currentStep ?? 0;
    _values = [];
    setValues();
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      physics: const BouncingScrollPhysics(),
      type: widget.type,
      steps: widget.steps,
      onStepTapped: (newIndex) {
        setState(() {
          _currentStep = newIndex;
          widget.currentStep = newIndex;
          widget.onStepTapped!(_currentStep);
        });
      },
      currentStep: _currentStep,
      onStepContinue: () {
        if (_currentStep != widget.steps.length - 1) {
          setState(() {
            _currentStep++;
            widget.currentStep = _currentStep;
            widget.onStepTapped!(_currentStep);
          });
        }
      },
      onStepCancel: () {
        if (_currentStep != 0) {
          setState(() {
            _currentStep--;
            widget.currentStep = _currentStep;
            widget.onStepTapped!(_currentStep);
          });
        }
      },
      controlsBuilder: (context, details) {
        return Row(
          children: <Widget>[
            if (details.currentStep != 0)
              TextButton(
                onPressed: details.onStepCancel,
                child: const Text('Anterior'),
              ),
            if (details.currentStep != widget.steps.length - 1)
              TextButton(
                onPressed: details.onStepContinue,
                child: const Text('Siguiente'),
              )
          ],
        );
      },
    );
  }
}
