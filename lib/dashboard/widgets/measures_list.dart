import 'package:flutter/material.dart';
import '../models/measures_model.dart';
import '../utils/constants.dart';
import '../utils/dimens.dart';

class MeasuresList extends StatelessWidget {
  final List<MeasuresModel>? measures;
  const MeasuresList({this.measures, super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> metricsList = Constants.metricsList;
    if (measures == null || measures!.isEmpty) {
      return const Center();
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: metricsList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(Dimens.margin_8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(metricsList[index].keys.first.toString()),
                  Text(measures
                          ?.where((element) =>
                              element.metricUuid ==
                              metricsList[index].values.first.toString())
                          .toList()
                          .first
                          .value
                          .toString()
                          .split(".")[0] ??
                      "null")
                ],
              ),
            );
          },
        ),
      );
    }
  }
}
