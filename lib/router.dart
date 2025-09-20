import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:wabiz_app/model/project/project_model.dart';
import 'package:wabiz_app/views/category/category_page.dart';
import 'package:wabiz_app/views/favorit/favorite_page.dart';
import 'package:wabiz_app/views/home/home_page.dart';
import 'package:wabiz_app/views/login/sign_in_page.dart';
import 'package:wabiz_app/views/login/sign_up_page.dart';
import 'package:wabiz_app/views/my/my_page.dart';
import 'package:wabiz_app/views/project/add_project_page.dart';
import 'package:wabiz_app/views/project/add_reward_page.dart';
import 'package:wabiz_app/views/project/project_detail_page.dart';
import 'package:wabiz_app/views/wabiz_app_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final project = state.extra as Map<String, dynamic>;
        ProjectItemModel model = ProjectItemModel.fromJson(project);
        return ProjectDetailPage(project: model,);
      }
    ),
    GoRoute(
      path: '/add',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => AddProjectPage(),
      routes: [
        GoRoute(
          path: 'reward/:id',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) {
            final project = state.pathParameters['id']!;
            return AddRewardPage(projectId: project);
          },
        ),
      ]
    ),
    GoRoute(
      path: '/login',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => SignInPage(),
    ),
    GoRoute(
      path: '/sign-up',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return SignUpPage();
      }
    ),

    // 바텀네비 하위
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return WabizAppShell(
          currentIndex: switch (state.uri.path) {
            var p when p.startsWith('/favorite') => 2,
            var p when p.startsWith('/my') => 3,
            _ => 0,
          },
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/home',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: '/category/:id',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return CategoryPage(categoryId: id,);
              }
            ),
          ]
        ),
        GoRoute(
          path: '/my',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) {
            return MyPage();
          }
        ),
        GoRoute(
          path: '/favorite',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) {
            return FavoritePage();
          }
        )
      ],
    ),
  ],
);
