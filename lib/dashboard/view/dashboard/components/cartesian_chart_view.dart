import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../utils/constants.dart';
import '../../../utils/dimens.dart';
import '../../main_page.dart';

class AnalysisCartesianChartView extends StatelessWidget {
  const AnalysisCartesianChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: Card(
        color: Colors.white,
        elevation: 2,
        child: Observer(builder: (_) {
          return Center(
            child: (store.projectDetails.analysisLogs != null)
                ? SfCartesianChart(
                    title: ChartTitle(text: 'Analysis Chart'),
                    legend: Legend(
                        isVisible: true, position: LegendPosition.bottom),
                    primaryXAxis: CategoryAxis(),
                    series: <ChartSeries>[
                      LineSeries<ChartData, String>(
                          dataSource: [
                            for (var log
                                in store.projectDetails.analysisLogs!.reversed)
                              ChartData(
                                  x: log.createdAt,
                                  y: double.parse(log.analysisIssues
                                          ?.where((element) =>
                                              element.metricUuid ==
                                              Constants
                                                  .metricsList[0].values.first)
                                          .toList()
                                          .first
                                          .total ??
                                      '0'))
                          ],
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          dataLabelSettings: DataLabelSettings(isVisible: true))
                    ],
                  )
                : const Center(child: Text('No data to display')),
          );
        }),
      ),
    );
  }
}

class ChartData {
  final String? x;
  final double? y;
  ChartData({this.x, this.y});
}
