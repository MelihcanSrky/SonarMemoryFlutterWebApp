import 'package:flutter/material.dart';

class Constants {
  static const API_KEY = "sqa_0ef3bca6b228f98914f623cee13bfe6fe4293afd";

  static const metricsList = [
    {"Bugs": "AYYiToXu9esxNIBLsvrJ"},
    {"Vulnerabilities": "AYYiToXv9esxNIBLsvrL"},
    {"Code Smells": "AYYiToXt9esxNIBLsvrH"},
    {"lines": "AYYiToXA9esxNIBLsvqA"},
    {"Reliability": "AYYiToX29esxNIBLsvra"},
    {"Security": "AYYiToX49esxNIBLsvre"},
    {"Security Review": "AYYiToX59esxNIBLsvrg"},
    {"Coverage": "AYYiToXd9esxNIBLsvqg"},
    {"Duplicated": "AYYiToXj9esxNIBLsvqu"},
    {"Cyclomatic": "AYYiToXW9esxNIBLsvqR"},
    {"Cognitive": "AYYiToXa9esxNIBLsvqZ"},
    {"Security Hotspots": "AYYiToX79esxNIBLsvrl"}
  ];
  static const issuesList = ["MAJOR", "MINOR", "BLOCKER", "CRITICAL"];
  static const typesList = ["BUG", "VULNERABILITY", "CODE_SMELL"];

  static const analysisIssuesList = [
    {"Bugs": "AYYiToXu9esxNIBLsvrJ"},
    {"Vulnerabilities": "AYYiToXv9esxNIBLsvrL"},
    {"Code Smells": "AYYiToXt9esxNIBLsvrH"},
    {"Security Hotspots": "AYYiToX79esxNIBLsvrl"}
  ];
  static const analysisIssuesIconsList = [
    {"Bugs": (Icons.bug_report)},
    {"Vulnerabilities": Icons.lock_open},
    {"Code Smells": Icons.code},
    {"Security Hotspots": Icons.security}
  ];
}
