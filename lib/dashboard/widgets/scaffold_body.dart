import 'package:flutter/material.dart';
import 'package:flutter_sonar_app/dashboard/utils/responsive.dart';

class ScaffoldBody extends StatelessWidget {
  final Widget middleBlock;
  const ScaffoldBody({required this.middleBlock, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (Responsive.isDesktop(context))
          Flexible(flex: 1, child: Container()),
        Flexible(flex: 2, child: middleBlock),
        if (Responsive.isDesktop(context))
          Flexible(flex: 1, child: Container()),
      ],
    );
    ;
  }
}
