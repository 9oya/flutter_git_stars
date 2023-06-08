import 'package:flutter/material.dart';
import 'package:flutter_git_stars/presentation/route/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lime),
        useMaterial3: true,
      ),
      routerConfig: RouterUtils.router,
    );
  }
}
