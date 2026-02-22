import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import '../../page/main/main_page.dart';
import '../../page/auth/auth_page.dart';
import '../../page/my_data/my_data_page.dart';
import '../../page/profile/profile_page.dart';
import 'route_path.dart';
import 'scaffold_with_nav_bar.dart';

class RoutePathParameters {
  static final RoutePathParameters _routePathParameters =
      RoutePathParameters._internal();

  factory RoutePathParameters() => _routePathParameters;

  RoutePathParameters._internal();
}

/*
final List<StatefulShellBranch> _bottomNavBranches = <StatefulShellBranch>[
  StatefulShellBranch(
    rootLocation: RoutePath.mainScreenPath,
    name: 'home',
  ),
  // StatefulShellBranch(
  //   rootLocation: RoutePath.orderScreenPath,
  //   name: 'order',
  // ),
  // StatefulShellBranch(
  //   rootLocation: RoutePath.historyScreenPath,
  //   name: 'history',
  // ),
  StatefulShellBranch(
    rootLocation: RoutePath.profileScreenPath,
    name: 'profile',
  ),
];
*/

final List<StatefulShellBranch> bottomNavBranches = <StatefulShellBranch>[
  StatefulShellBranch(
    routes: [
      GoRoute(
        path: RoutePath.mainScreenPath,
        name: MainPage.name,
        builder: (context, state) => const MainPage(),
      ),
    ],
  ),
  StatefulShellBranch(
    routes: [
      GoRoute(
          path: RoutePath.profileScreenPath,
          name: ProfilePage.name,
          builder: (context, state) => const ProfilePage(),
          routes: [
            GoRoute(
              path: RoutePath.myDataPagePath,
              name: MyDataPage.name,
              builder: (context, state) => const MyDataPage(),
            ),
          ]),
    ],
  ),
];

class RoutesInit {
  factory RoutesInit() {
    return _instance ??= RoutesInit._();
  }

  RoutesInit._();

  static RoutesInit? _instance;
  final GoRouter router = GoRouter(
    initialLocation: RoutePath.init,
    observers: [BotToastNavigatorObserver(), FlutterSmartDialog.observer],
    routes: [
      GoRoute(
        path: RoutePath.init,
        name: RoutePath.init,
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: RoutePath.authScreenPath,
        name: AuthPage.name,
        builder: (context, state) => const AuthPage(),
      ),
      StatefulShellRoute(
        branches: bottomNavBranches,
        //builder: (BuildContext context, GoRouterState state, Widget child) {
        //return ScaffoldWithNavBar(body: child);
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        navigatorContainerBuilder: (context, navigationShell, children) {
          return IndexedStack(
            index: navigationShell.currentIndex,
            children: children,
          );
        },
      ),
    ],
  );
}

/*
      StatefulShellRoute.indexedStack(
        branches: bottomNavBranches,
        // builder の第3引数は Widget ではなく StatefulNavigationShell になります
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          // この navigationShell が、現在のタブ情報や切り替え機能を持っています
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
      )

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 現在のブランチの画面を表示
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        // 現在のインデックスを shell から取得
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) {
          // タブ切り替えを実行
          navigationShell.goBranch(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
*/
