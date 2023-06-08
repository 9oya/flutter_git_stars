import 'package:flutter/material.dart';
import 'package:flutter_git_stars/presentation/route/router.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.child});

  final Widget child;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context
                  .go(Routes.users.path, extra: {'title': Routes.users.title});
              break;
            case 1:
              context
                  .go(Routes.stars.path, extra: {'title': Routes.stars.title});
              break;
          }

          setState(() {
            currentIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.list_alt),
            label: Routes.users.title,
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.star),
            label: Routes.stars.title,
            backgroundColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}