import 'package:flutter/material.dart';
import 'package:flutter_git_stars/presentation/utils/di/di.dart';

import 'app.dart';

void main() {
  configureDependencies();
  runApp(const App());
}
