import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partier/services/auth_service.dart';
import 'package:provider/provider.dart';

import '../../routing/app_router.dart';

class BottomBarWidget extends StatelessWidget {
  final Widget child;
  const BottomBarWidget({super.key, required this.child});

  int getCurrentIndex(BuildContext context) {
    final String location = GoRouter.of(context).location;
    if (location.startsWith('/discovery')) {
      return 1;
    }
    else if (location.startsWith('/create-event')) {
      return 0;
    }
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = getCurrentIndex(context);

    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Scopri'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.group),
                label: Text('Crea'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.logout),
                label: Text('Logout'),
              ),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) {
              switch (index) {
                case 0:
                  DiscoveryRoute().go(context);
                  break;
                case 1:
                  CreateEventRoute().go(context);
                  break;
                case 2:
                  context.read<LoginInfo>().signOut();
                  break;
              }
            },
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}