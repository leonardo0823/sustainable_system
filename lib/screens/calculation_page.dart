import 'package:animate_do/animate_do.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../components/dialog_software.dart';
import '../components/my_stepper.dart';
import '../components/step_content.dart';
import '../utils/constants.dart';
import '../utils/features_discoveries.dart';
import '../utils/functions.dart';
import '../utils/pdf.dart';
import 'history_page.dart';
import 'home_page.dart';

// ignore: must_be_immutable
class CalculationPage extends StatefulWidget {
  List<String>? metricsNames;
  String softwareName;
  List<Map<String, Map<int, List>>>? metrics;

  CalculationPage(
      {Key? key,
      this.softwareName = 'default',
      this.metricsNames,
      this.metrics})
      : super(key: key);

  @override
  State<CalculationPage> createState() => _CalculationPageState();
}

class _CalculationPageState extends State<CalculationPage>
    with SingleTickerProviderStateMixin {
  late List<int> _values;
  late List<String> _metricsNames;
  late List<Map<String, Map<int, List>>> _metrics;
  late List<String> _filed;
  late String _clasification;
  late int _total;
  late List<int> _currentSteps;

  late BuildContext cont;

  @override
  void initState() {
    if (getShowDiscovery(key_calculation) ?? true) {
      SchedulerBinding.instance.addPostFrameCallback(
        (Duration duration) => showDiscovery(cont,
            listId: [
              kFeatureId6SaveSoftware,
              kFeatureId7GeneratePDF,
              kFeatureId8Points,
              kFeatureId9Clasification,
              kFeatureId10Metric,
              kFeatureId11MetricPoints,
              kFeatureId12Factor,
            ],
            key: key_calculation),
      );
    }
    super.initState();

    if (widget.metrics == null) {
      _metricsNames = metricsNames;
      _metrics = metrics;
    } else {
      _metricsNames = widget.metricsNames!;
      _metrics = widget.metrics!;
    }

    _values = [];
    _filed = [];
    _total = 0;

    _setValues();
  }

  int getSelectedValue(Map<dynamic, List> map) {
    var list = map.entries.toList();
    for (int i = 0; i < list.length; i++) {
      if (list[i].value[1]) {
        return list[i].key;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    FaIcon iconSave = widget.softwareName == 'default'
        ? const FaIcon(FontAwesomeIcons.solidFloppyDisk)
        : const FaIcon(FontAwesomeIcons.penToSquare);
    setState(() {
      cont = context;
    });
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        Get.offAll(
          () => widget.softwareName == 'default'
              ? SlideInLeft(
                  duration: const Duration(milliseconds: 250),
                  child: const HomePage())
              : SlideInLeft(
                  duration: const Duration(milliseconds: 250),
                  child: HistoryPage(),
                ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primarySwatch,
          leading: IconButton(
            onPressed: () => Get.offAll(
              () => widget.softwareName == 'default'
                  ? SlideInLeft(
                      duration: const Duration(milliseconds: 250),
                      child: const HomePage())
                  : SlideInLeft(
                      duration: const Duration(milliseconds: 250),
                      child: HistoryPage(),
                    ),
            ),
            icon: const FaIcon(FontAwesomeIcons.chevronLeft),
          ),
          elevation: 0,
          scrolledUnderElevation: 0,
          actions: [
            buildWidget(context,
                child: Tooltip(
                  triggerMode: TooltipTriggerMode.tap,
                  message: 'Clasificación: $_clasification',
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _clasification,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          color: clasificationColor[_clasification]),
                    ),
                  ),
                ),
                featureId: kFeatureId9Clasification,
                tapTarget: Text(
                  _clasification,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                      color: clasificationColor[_clasification]),
                ),
                contentLocation: ContentLocation.below,
                title: 'Clasificación',
                description: 'Aquí se muestra la clasificación'),
            buildWidget(context,
                child: Tooltip(
                  triggerMode: TooltipTriggerMode.tap,
                  message: 'Puntos: $_total',
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _total.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          color: clasificationColor[_clasification]),
                    ),
                  ),
                ),
                featureId: kFeatureId8Points,
                tapTarget: Text(
                  _total.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                      color: clasificationColor[_clasification]),
                ),
                contentLocation: ContentLocation.below,
                title: 'Puntos',
                description: 'Aquí se muestra los puntos'),
            buildWidget(context,
                child: IconButton(
                  onPressed: _createPDF,
                  icon: const FaIcon(FontAwesomeIcons.solidFilePdf),
                ),
                featureId: kFeatureId7GeneratePDF,
                tapTarget: FaIcon(FontAwesomeIcons.solidFilePdf),
                contentLocation: ContentLocation.below,
                title: 'Generar PDF',
                description:
                    'Pulse aquí para generar una documentación en un archivo PDF'),
            buildWidget(context,
                child: IconButton(
                  onPressed: _showDialogAddSoftware,
                  icon: iconSave,
                ),
                featureId: kFeatureId6SaveSoftware,
                tapTarget: iconSave,
                contentLocation: ContentLocation.below,
                title:
                    '${widget.softwareName == 'default' ? 'Guardar' : 'Editar'}',
                description:
                    'Pulse aquí para ${widget.softwareName == 'default' ? 'guardar' : 'editar'} el cálculo'),
          ],
        ),
        body: DefaultTabController(
          length: _metrics.length,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  forceElevated: false,
                  scrolledUnderElevation: 0,
                  backgroundColor: primarySwatch,
                  toolbarHeight: widget.softwareName != 'default' ? 35 : 0,
                  centerTitle: true,
                  title: widget.softwareName != 'default'
                      ? Text(widget.softwareName)
                      : null,
                  pinned: true,
                  bottom: TabBar(
                    indicatorColor: primarySwatch[900],
                    unselectedLabelColor: primarySwatch[200],
                    isScrollable: true,
                    labelColor: Colors.white,
                    indicatorWeight: 4,
                    tabs:
                        _metricsNames.asMap().entries.toList().map((metricMap) {
                      return (metricMap.key == 1)
                          ? buildWidget(context,
                              featureId: kFeatureId10Metric,
                              tapTarget: Text(metricMap.value),
                              child: _buildTabMetric(context, metricMap),
                              contentLocation: ContentLocation.below,
                              title: 'Métrica',
                              description:
                                  'Pulse aquí o deslice la pantalla para desplazarse por las métricas')
                          : _buildTabMetric(context, metricMap);
                    }).toList(),
                  ),
                )
              ];
            },
            body: TabBarView(
              physics: GetPlatform.isDesktop
                  ? const NeverScrollableScrollPhysics()
                  : const BouncingScrollPhysics(),
              children: _metrics.asMap().entries.map((metrics) {
                return SizedBox(
                  height: double.infinity,
                  child: MyStepper(
                    onStepTapped: (value) {
                      setState(() {
                        _currentSteps[metrics.key] = value;
                      });
                    },
                    steps: metrics.value.entries
                        .toList()
                        .asMap()
                        .entries
                        .map((factors) {
                      return Step(
                        isActive: _currentSteps[metrics.key] >= factors.key,
                        state: StepState.complete,
                        title: (metrics.key == 0 && factors.key == 0)
                            ? buildWidget(context,
                                featureId: kFeatureId12Factor,
                                tapTarget: Text(factors.value.key),
                                child: Text(factors.value.key),
                                contentLocation: ContentLocation.below,
                                title: 'Factor',
                                description:
                                    'Pulse aquí o en otro factor,\no en los botones Siguiente\no Anterior para, navegar\nentre los factores y marcar\nuna opción')
                            : Text(factors.value.key),
                        content: StepContent(
                          stepMap: factors.value.value,
                          value: getSelectedValue(factors.value.value),
                          onChange: (value) {
                            _metrics[metrics.key][factors.value.key] = value;

                            _setValues();
                          },
                        ),
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Tab _buildTabMetric(BuildContext context, MapEntry<int, String> metricMap) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(metricMap.value),
          const SizedBox(
            width: 5,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: clasificationColor[_filed[metricMap.key]],
            ),
            child: (metricMap.key == 1)
                ? buildWidget(context,
                    featureId: kFeatureId11MetricPoints,
                    tapTarget: Text(
                      ' ${_values[metricMap.key]} ',
                    ),
                    child: Text(
                      ' ${_values[metricMap.key]} ',
                    ),
                    contentLocation: ContentLocation.below,
                    title: 'Puntos de Métrica',
                    description: 'Aquí se muestra los puntos de esta métrica')
                : Text(
                    ' ${_values[metricMap.key]} ',
                  ),
          ),
        ],
      ),
    );
  }

  void _setValues() {
    setState(() {
      List<int> values = [];
      List<String> filed = [];
      int sum = 0;
      for (int i = 0; i < _metrics.length; i++) {
        int cont = 0;
        var factors = _metrics[i].entries.toList();
        for (int j = 0; j < factors.length; j++) {
          var optionsMap = factors[j].value;
          var options = optionsMap.entries.toList();
          for (int k = 0; k < options.length; k++) {
            if (options[k].value[1]) {
              cont += options[k].key;
            }
          }
        }
        values.add(cont);
        filed.add(clasifications[i][cont]!);
        sum += cont;
      }
      _currentSteps = List.filled(_metrics.length, 0);
      _values = values;
      _filed = filed;
      _clasification = getClasification(sum);
      _total = sum;
    });
  }

  void _showDialogAddSoftware() {
    showDialog(
      context: context,
      builder: (BuildContext context) => DialogSoftwareWidget(
        softwareName: widget.softwareName,
        metricsNames: _metricsNames,
        metrics: _metrics,
        rating: _clasification,
        points: _total,
        page: const HomePage(),
      ),
    );
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    List<PdfPage> pages = [];
    PdfPage currentPage = (pages..add(document.pages.add())).last;

    currentPage.graphics.drawImage(
      PdfBitmap(await readImageData('icon.png')),
      Rect.fromLTWH(230, 30, 100, 100),
    );

    currentPage.graphics.drawString('Sostenibilidad del Software',
        PdfStandardFont(PdfFontFamily.timesRoman, 85),
        bounds: Rect.fromLTWH(0, 250, currentPage.getClientSize().width,
            currentPage.getClientSize().height),
        format: PdfStringFormat(alignment: PdfTextAlignment.center));

    currentPage = (pages..add(document.pages.add())).last;

    double top = 30;
    String result = '';

    PdfLayoutResult? layoutResult;

    for (int i = 0; i < _metrics.length; i++) {
      var factors = _metrics[i].entries.toList();
      result +=
          "${i == 0 ? '' : '. '}Al analizar la métrica ${_metricsNames[i].toLowerCase()}";

      layoutResult = PdfTextElement(
              text: '${_metricsNames[i]} (${_values[i]} puntos)',
              font: PdfStandardFont(PdfFontFamily.timesRoman, 18,
                  style: PdfFontStyle.bold),
              format: PdfStringFormat(alignment: PdfTextAlignment.justify))
          .draw(
              page: currentPage,
              bounds: Rect.fromLTWH(0, top, currentPage.getClientSize().width,
                  currentPage.getClientSize().height));

      if (currentPage.getClientSize().height - 30 <=
          layoutResult!.bounds.bottom) {
        currentPage = (pages..add(document.pages.add())).last;
        top = 30;
      } else {
        top = layoutResult.bounds.bottom + 30;
      }

      for (int j = 0; j < factors.length; j++) {
        var optionsMap = factors[j].value;
        var options = optionsMap.entries.toList();
        var selectedOption = options.firstWhere((element) => element.value[1]);
        result += '; en cuanto a, ${factors[j].key.toLowerCase()};';

        layoutResult = PdfTextElement(
          text: '· ${factors[j].key} (${selectedOption.key} puntos)',
          font: PdfStandardFont(PdfFontFamily.timesRoman, 14,
              style: PdfFontStyle.italic),
          format: PdfStringFormat(
              alignment: PdfTextAlignment.justify, paragraphIndent: 8),
        ).draw(
            page: currentPage,
            bounds: Rect.fromLTWH(0, top, currentPage.getClientSize().width,
                currentPage.getClientSize().height));

        if (currentPage.getClientSize().height - 30 <=
            layoutResult!.bounds.bottom) {
          currentPage = (pages..add(document.pages.add())).last;
          top = 30;
        } else {
          top = layoutResult.bounds.bottom + 30;
        }

        for (int k = 0; k < options.length; k++) {
          result += options[k].value[1]
              ? " ${options[k].value[0].toLowerCase()}(${options[k].key} puntos)${i == _metrics.length - 1 && j == factors.length - 1 ? '.' : ''}"
              : '';
          layoutResult = PdfTextElement(
            font: PdfStandardFont(
              PdfFontFamily.timesRoman,
              12,
              style: options[k].value[1] ? PdfFontStyle.underline : null,
            ),
            format: PdfStringFormat(
                alignment: PdfTextAlignment.justify, paragraphIndent: 16),
            text: '- ${options[k].value[0]}: ${options[k].key}',
          ).draw(
              page: currentPage,
              bounds: Rect.fromLTWH(0, top, currentPage.getClientSize().width,
                  currentPage.getClientSize().height));

          if (currentPage.getClientSize().height - 30 <=
              layoutResult!.bounds.bottom) {
            currentPage = (pages..add(document.pages.add())).last;
            top = 30;
          } else {
            top = layoutResult.bounds.bottom + 30;
          }
        }
      }
    }

    currentPage = (pages..add(document.pages.add())).last;
    top = 30;

    layoutResult = PdfTextElement(
      font: PdfStandardFont(
        PdfFontFamily.timesRoman,
        14,
      ),
      format: PdfStringFormat(alignment: PdfTextAlignment.justify),
      text: 'Por lo Tanto:',
    ).draw(
        page: currentPage,
        bounds: Rect.fromLTWH(0, top, currentPage.getClientSize().width,
            currentPage.getClientSize().height));

    layoutResult = PdfTextElement(
      font: PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
      ),
      format: PdfStringFormat(alignment: PdfTextAlignment.justify),
      text: result,
    ).draw(
        page: currentPage,
        bounds: Rect.fromLTWH(
            0,
            layoutResult!.bounds.bottom + 30,
            currentPage.getClientSize().width,
            currentPage.getClientSize().height));

    layoutResult = PdfTextElement(
      font: PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
      ),
      format: PdfStringFormat(alignment: PdfTextAlignment.justify),
      text:
          'Con un total de $_total puntos se concluye que este software es $_clasification.',
    ).draw(
        page: currentPage,
        bounds: Rect.fromLTWH(
            0,
            layoutResult!.bounds.bottom + 30,
            currentPage.getClientSize().width,
            currentPage.getClientSize().height));

    List<int> bytes = await document.save();
    document.dispose();

    await saveAndLaunchFile(bytes, 'documentation.pdf');
  }
}
