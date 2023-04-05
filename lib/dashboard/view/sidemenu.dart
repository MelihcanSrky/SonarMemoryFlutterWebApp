import 'package:flutter/material.dart';
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
          DrawerListTile(
              title: Strings.projects,
              icon: Icon(Icons.account_tree_rounded, color: Colors.white),
              press: () {
                Get.offNamed(Applinks.PROJECTS);
              }),
          DrawerListTile(
            title: Strings.dashboard,
            icon: Icon(Icons.dashboard, color: Colors.white),
            press: () {
              Get.offNamed(Applinks.DASHBOARD, arguments: {"projectUuid": ""});
            },
          ),
          // Switch(
          //     value: store.isDarkMode!,
          //     onChanged: (value) {
          //       store.changeTheme();
          //       setState(() {});
          //     })
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
  });

  final Icon icon;
  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: Dimens.Title2),
      ),
      leading: icon,
      onTap: press,
    );
  }
}
