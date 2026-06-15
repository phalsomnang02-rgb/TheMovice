import 'package:flutter/material.dart';
import 'package:flutter_application_1/movie_module/screens/people_screen.dart';
import 'package:flutter_application_1/movie_module/screens/search_screen_movie.dart';
import 'package:flutter_application_1/movie_module/screens/setting_screen.dart';
import 'nowplaying_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';


class ParentScreen extends StatefulWidget {
  const ParentScreen({super.key});

  @override
  State<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: NowplayingScreen(),
          item: ItemConfig(
            icon: Icon(Icons.home),
            title: "Home",
            activeForegroundColor: Theme.of(context).colorScheme.primary,
          ),
        ),
        PersistentTabConfig(
          screen:PeopleScreen(),
          item: ItemConfig(
            icon: Icon(Icons.person),
            title: "People",
            activeForegroundColor: Theme.of(context).colorScheme.primary,
          ),
        ),
        PersistentTabConfig(
          screen: SearchScreen(),
          item: ItemConfig(
            icon: Icon(Icons.search),
            title: "Search",
            activeForegroundColor: Theme.of(context).colorScheme.primary,
          ),
        ),
         PersistentTabConfig(
          screen: SettingScreen(),
          item: ItemConfig(
            icon: Icon(Icons.settings),
            title: "Settings",
            activeForegroundColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
      navBarBuilder: (NavBarConfig p1) {
        return Style1BottomNavBar(
          navBarConfig: p1,
          navBarDecoration: NavBarDecoration(
            color: Theme.of(context).colorScheme.onInverseSurface,
          ),
        );
      },
    );
  }
}
