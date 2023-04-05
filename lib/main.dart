import 'package:flutter/material.dart';
import 'package:flutter_sonar_app/dashboard/view/main_page.dart';
import 'package:provider/provider.dart';

import 'dashboard/controllers/menu_app_controller.dart';
import 'dashboard/utils/strings.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Strings.appTitle,
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => MenuAppController()),
          ],
          child: Scaffold(
            body: MainView(),
          ),
        ));
  }
}
