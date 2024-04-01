// // private navigators
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:kaveri/constants/bottom_nav_bar.dart';
// import 'package:kaveri/screens/brand.dart';
// import 'package:kaveri/screens/cart.dart';
// import 'package:kaveri/screens/category.dart';

// final _rootNavigatorKey = GlobalKey<NavigatorState>();
// final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
// final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
// final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');

// // the one and only GoRouter instance
// final goRouter = GoRouter(
//   initialLocation: '/category',
//   navigatorKey: _rootNavigatorKey,
//   routes: [
//     StatefulShellRoute.indexedStack(
//       builder: (context, state, navigationShell) {
//         return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
//       },
//       branches: [
//         // first branch (A)
//         StatefulShellBranch(
//           navigatorKey: _shellNavigatorCKey,
//           routes: [
//             GoRoute(
//               path: '/category',
//               pageBuilder: (context, state) => const NoTransitionPage(
//                 child: CategoryScreen(),
//               ),
//             ),
//           ],
//         ),
//         StatefulShellBranch(
//           navigatorKey: _shellNavigatorBKey,
//           routes: [
//             GoRoute(
//               path: '/brand',
//               pageBuilder: (context, state) => const NoTransitionPage(
//                 child: BrandScreen(),
//               ),
//             ),
//           ],
//         ),

//         StatefulShellBranch(
//           navigatorKey: _shellNavigatorAKey,
//           routes: [
//             // top route inside branch
//             GoRoute(
//               path: '/cart',
//               pageBuilder: (context, state) => const NoTransitionPage(
//                 child: CartScreen(),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   ],
// );

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kaveri/constants/bottom_nav_bar.dart';
import 'package:kaveri/screens/auth/login.dart';
import 'package:kaveri/brand/presentation/brand.dart';
import 'package:kaveri/screens/cart.dart';
import 'package:kaveri/category/presentation/category.dart';
import 'package:kaveri/screens/selectedcategory.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');

final goRouter = GoRouter(
  initialLocation: '/category',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: LoginScreen(),
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCKey,
          routes: [
            GoRoute(
              name: CategoryScreen.routeName,
                path: '/category',
                pageBuilder: (context, state) => const NoTransitionPage(
                      child: CategoryScreen(),
                    ),
                routes: [
                  GoRoute(
                    path: 'selected/category/:id',
                    builder: (context, state) => const SelectedCategory(),
                  ),
                ]),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            GoRoute(
              path: '/brand',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: BrandScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            // top route inside branch
            GoRoute(
              path: '/cart',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: CartScreen(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
