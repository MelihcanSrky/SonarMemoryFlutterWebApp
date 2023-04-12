import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_sonar_app/dashboard/controllers/main_screen_controller.dart';
import 'package:get/get.dart';

import '../utils/CustomColors.dart';
import '../utils/dimens.dart';
import '../utils/strings.dart';
import 'main_page.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: CustomColors.drawerColor,
      child: ListView(
        children: [
          const DrawerHeader(
            child: Center(
              child: Text(Strings.sonarMemory,
                  style:
                      TextStyle(color: Colors.white, fontSize: Dimens.Title1)),
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          Observer(builder: (_) {
            return DrawerListTile(
                route: Applinks.PROJECTS,
                title: Strings.projects,
                icon: Icon(Icons.account_tree_rounded,
                    color: (store.currentRoute == Applinks.PROJECTS)
                        ? Colors.white
                        : Colors.grey),
                press: () {
                  store.changeRoute(Applinks.PROJECTS);
                  print(store.currentRoute);
                  Get.offNamed(Applinks.PROJECTS);
                });
          }),
          Observer(builder: (_) {
            return DrawerListTile(
              route: Applinks.DASHBOARD,
              title: Strings.dashboard,
              icon: Icon(Icons.dashboard,
                  color: (store.currentRoute == Applinks.DASHBOARD)
                      ? Colors.white
                      : Colors.grey),
              press: () {
                store.changeRoute(Applinks.DASHBOARD);
                print(store.currentRoute);
                Get.offNamed(Applinks.DASHBOARD,
                    arguments: {"projectUuid": ""});
              },
            );
          }),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.press,
    required this.route,
  });

  final Icon icon;
  final String title;
  final VoidCallback press;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            color: (store.currentRoute == route) ? Colors.white : Colors.grey,
            fontSize: Dimens.Title2),
      ),
      leading: icon,
      onTap: press,
    );
  }
}
