import 'package:flutter/material.dart';

import '../models/issues_model.dart';
import '../utils/constants.dart';
import '../utils/dimens.dart';

class IssuesList extends StatelessWidget {
  final List<IssuesModel>? issues;
  const IssuesList({this.issues, super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> issuesList = Constants.issuesList;
    if (issues == null || issues!.isEmpty) {
      return const Center();
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: issuesList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(Dimens.margin_8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(issuesList[index].toString()),
                  Text(issues
                          ?.where((element) =>
                              element.severity == issuesList[index].toString())
                          .toList()
                          .length
                          .toString() ??
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
