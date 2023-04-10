import 'package:flutter/material.dart';
import 'package:flutter_sonar_app/dashboard/view/main_page.dart';

import '../../../utils/dimens.dart';
import '../../../utils/strings.dart';
import 'project_detail_grid_view.dart';

class AnalysisHistory extends StatelessWidget {
  final String? projectUuid;
  const AnalysisHistory({this.projectUuid, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: Dimens.margin_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                Strings.analysisHistory,
                style: TextStyle(
                  fontSize: Dimens.Title1,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimens.margin_16),
          ProjectDetailGridView(
            projectUuid: projectUuid,
          )
        ],
      ),
    );
  }
}
