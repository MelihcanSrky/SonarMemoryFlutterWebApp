import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_sonar_app/dashboard/models/analysis_issues.dart';
import 'package:flutter_sonar_app/dashboard/models/projects_n_branches_model.dart';
import 'package:flutter_sonar_app/dashboard/view/main_page.dart';
import 'package:flutter_sonar_app/themes/issues_card_theme.dart';

import '../../../utils/CustomColors.dart';
import '../../../utils/constants.dart';
import '../../../utils/dimens.dart';
import '../../../utils/responsive.dart';
import 'cartesian_chart_view.dart';

class AnalysisIssues extends StatefulWidget {
  final String? projectUuid;
  final List<ProjectsNBranchesModel> project;
  const AnalysisIssues({required this.project, this.projectUuid, super.key});

  @override
  State<AnalysisIssues> createState() => _AnalysisIssuesState();
}

class _AnalysisIssuesState extends State<AnalysisIssues> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Observer(builder: (_) {
            final projectName = store.projectDetails.project?[0].name;
            final versionName = store.projectDetails
                .analysisLogs?[store.gridVM.selectedRow ?? 0].versionName;
            return Text(
              "Analysis Issues: ${projectName ?? 'N/A'} - Version: ${versionName ?? 'N/A'}",
              style: const TextStyle(
                fontSize: Dimens.Title1,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            );
          })
        ]),
        const SizedBox(height: Dimens.margin_16),
        Observer(builder: (_) {
          if (store.projectDetails.analysisLogs != null &&
              store.projectDetails.analysisLogs!.isNotEmpty) {
            final _analysisIssuesList = store.projectDetails
                .analysisLogs![store.gridVM.selectedRow ?? 0].analysisIssues;
            return Responsive(
              mobile: Column(
                children: [
                  AnalysisIssuesGridView(
                    list: _analysisIssuesList,
                    crossAxisCount: _size.width < 650 ? 1 : 2,
                    childAspectRatio: _size.width < 650 ? 2 : 2.2,
                  ),
                  AnalysisCartesianChartView()
                ],
              ),
              tablet: Column(
                children: [
                  AnalysisIssuesGridView(
                    list: _analysisIssuesList,
                    crossAxisCount: _size.width < 900 ? 2 : 2,
                    childAspectRatio: _size.width < 900 ? 2.2 : 2.4,
                  ),
                  AnalysisCartesianChartView()
                ],
              ),
              desktop: Row(
                children: [
                  Flexible(
                    flex: 11,
                    child: AnalysisIssuesGridView(
                      list: _analysisIssuesList,
                      childAspectRatio: _size.width < 1500 ? 1.6 : 2,
                    ),
                  ),
                  Flexible(flex: 9, child: AnalysisCartesianChartView())
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        })
      ],
    );
  }
}

class AnalysisIssuesGridView extends StatefulWidget {
  final List<AnalysisIssuesModel>? list;
  const AnalysisIssuesGridView(
      {this.list,
      this.crossAxisCount = 2,
      this.childAspectRatio = 1,
      super.key});

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<AnalysisIssuesGridView> createState() => _AnalysisIssuesGridViewState();
}

class _AnalysisIssuesGridViewState extends State<AnalysisIssuesGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.list!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        childAspectRatio: widget.childAspectRatio,
        mainAxisSpacing: Dimens.margin_16,
        crossAxisSpacing: Dimens.margin_16,
      ),
      itemBuilder: (context, index) => AnalysisInfoCard(
        index: index,
        list: widget.list,
        icon: Icon(Constants.analysisIssuesIconsList[index].values.first,
            color: CustomColors.secondaryBlue),
        title: Constants.analysisIssuesList[index].keys.toString(),
      ),
    );
  }
}

class AnalysisInfoCard extends StatelessWidget {
  final int index;
  final List<AnalysisIssuesModel>? list;
  final Icon icon;
  final String title;
  const AnalysisInfoCard(
      {required this.index,
      this.list,
      required this.icon,
      required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    IssuesCardTheme issuesCardTheme =
        Theme.of(context).extension<IssuesCardTheme>()!;
    final issueCount = (list!
        .where((element) =>
            element.metricUuid ==
            Constants.analysisIssuesList[index].values.first)
        .first);
    final _dataGridController = store.gridVM.dataGridController;
    var isTwoRowsSelected = false;
    if (_dataGridController?.selectedRows.length == 2) {
      isTwoRowsSelected = true;
    } else {
      isTwoRowsSelected = false;
    }

    return Container(
      margin: const EdgeInsets.all(Dimens.margin_4),
      decoration: BoxDecoration(
        color: issuesCardTheme.secondaryColor,
        borderRadius: BorderRadius.circular(Dimens.margin_16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: issuesCardTheme.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimens.margin_16),
                topRight: Radius.circular(Dimens.margin_16),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: Dimens.margin_12),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: icon),
                Expanded(
                  child: Text(
                    title.substring(1, title.length - 1),
                    style: issuesCardTheme.titleTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(Dimens.margin_16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Dimens.margin_16),
                bottomRight: Radius.circular(Dimens.margin_16),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_dataGridController?.selectedRows.length == 2)
                  Observer(builder: (_) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildCompareColumns(0, context),
                        Text(
                          ">",
                          style: issuesCardTheme.subtitleTextStyle,
                        ),
                        buildCompareColumns(1, context)
                      ],
                    );
                  })
                else
                  Column(
                    children: [
                      Text(
                        ("Total: " + issueCount.total.toString()),
                        style: issuesCardTheme.subtitleTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: Dimens.margin_16),
                      const Divider(
                        color: CustomColors.primaryBlue,
                        thickness: 1,
                      ),
                      const SizedBox(height: Dimens.margin_8),
                      Table(children: [
                        TableRow(children: [
                          Text(
                            "Major: ${issueCount.major}",
                            style: issuesCardTheme.subtitleTextStyle,
                          ),
                          Text(
                            "Minor: ${issueCount.minor}",
                            style: issuesCardTheme.subtitleTextStyle,
                          ),
                          Text(
                            "Blocker: ${issueCount.blocker}",
                            style: issuesCardTheme.subtitleTextStyle,
                          ),
                          Text(
                            "Critical: ${issueCount.critical}",
                            style: issuesCardTheme.subtitleTextStyle,
                          ),
                        ]),
                      ]),
                    ],
                  )
              ],
            ),
          )
        ],
      ),
    );
  }

  Column buildCompareColumns(int rowIndex, BuildContext context) {
    IssuesCardTheme issuesCardTheme =
        Theme.of(context).extension<IssuesCardTheme>()!;
    final _dataGridController = store.gridVM.dataGridController;
    final versionCode = _dataGridController?.selectedRows[rowIndex]
            .getCells()[0]
            .value
            .toString() ??
        '';
    final issueCount = _dataGridController?.selectedRows[rowIndex]
            .getCells()[index + 2]
            .value
            .toString() ??
        '';
    return Column(
      children: [
        Text("Ver: ${versionCode}", style: issuesCardTheme.subtitleTextStyle),
        const SizedBox(height: Dimens.margin_8),
        Text(
          "Total:" + issueCount,
          style: issuesCardTheme.subtitleTextStyle,
        ),
      ],
    );
  }
}
