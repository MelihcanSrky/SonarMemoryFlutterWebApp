import 'package:flutter/material.dart';
import 'package:flutter_sonar_app/dashboard/controllers/main_screen_controller.dart';
import 'package:flutter_sonar_app/dashboard/view/sidemenu.dart';
import 'package:get/get.dart';

import '../../themes/themes.dart';
import '../utils/CustomColors.dart';
import '../utils/responsive.dart';
import '../view_model/base_view_model.dart';

final store = BaseViewModel();

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    store.init();
    store.changeRoute(Applinks.PROJECTS);
    return Scaffold(
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            Expanded(
              child: SideMenu(),
            ),
          Expanded(
            flex: 5,
            child: GetMaterialApp(
                theme: themes['light'],
                darkTheme: themes['dark'],
                themeMode: store.isDarkMode! ? ThemeMode.dark : ThemeMode.light,
                debugShowCheckedModeBanner: false,
                initialRoute: Applinks.PROJECTS,
                getPages: AppRoutes.pages),
          ),
        ],
      )),
    );
  }
}
