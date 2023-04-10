import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../utils/dimens.dart';
import '../../../widgets/issue_list.dart';
import '../../../widgets/measures_list.dart';
import '../../main_page.dart';

class IssuesMeasuresCard extends StatelessWidget {
  const IssuesMeasuresCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Card(
          child: Padding(
        padding: const EdgeInsets.all(Dimens.margin_8),
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.2,
          ),
          child: Column(
            children: [
              MeasuresList(
                measures: store.newProjectVM.measures,
              ),
              IssuesList(
                issues: store.newProjectVM.issues,
              ),
            ],
          ),
        ),
      ));
    });
  }
}
