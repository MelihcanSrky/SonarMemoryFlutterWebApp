import 'package:flutter_sonar_app/dashboard/view/dashboard/dashboard_page.dart';
import 'package:flutter_sonar_app/dashboard/view/new_project/new_project_page.dart';
import 'package:flutter_sonar_app/dashboard/view/projects/project_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: Applinks.PROJECTS, page: () => const ProjectsPage()),
    GetPage(name: Applinks.DASHBOARD, page: () => const DashboardView()),
    GetPage(name: Applinks.NEW_PROJECT, page: () => const NewProjectPage()),
  ];
}

class Applinks {
  static const String PROJECTS = '/projects';
  static const String DASHBOARD = '/dashboard';
  static const String NEW_PROJECT = '/new_project';
}
