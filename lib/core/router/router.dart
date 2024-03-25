import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos_application/core/router/redirect.dart';
import 'package:sos_application/core/utils/base_provider.dart';
import 'package:sos_application/feature/credential/provider/credential_provider.dart';
import 'package:sos_application/feature/home/pages/auth/register_page.dart';
import 'package:sos_application/feature/home/pages/directory/directory_page.dart';
import 'package:sos_application/feature/home/pages/home/home.dart';
import 'package:sos_application/feature/home/pages/profile/profile_page.dart';
import 'package:sos_application/feature/splash/screen/splash_page.dart';
import 'package:sos_application/main.dart';

enum RoutePath {
  splash(path: '/splash'),
  login(path: '/login'),
  home(path: '/'),
  location(path: '/location'),
  profile(path: '/profile'),
  directory(path: '/directory'),
  settings(path: '/settings');

  const RoutePath({required this.path});
  final String path;
}

Provider<GoRouter> routeProvider = Provider<GoRouter>((ref) {
  CredentialProvider listen = ref.watch(credentialProvider);

  return GoRouter(
    redirect: (context, state) => redirect(context, state),
    refreshListenable: listen,
    routes: [
      GoRoute(
        path: RoutePath.splash.path,
        pageBuilder: (context, state) => const MaterialPage(
          child: SplashPage(),
        ),
      ),
      GoRoute(
        path: RoutePath.login.path,
        pageBuilder: (context, state) => const MaterialPage(
          child: RegisteryPage(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => Root(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePath.home.path,
                pageBuilder: (context, state) => const MaterialPage(
                  child: HomePage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePath.directory.path,
                pageBuilder: (context, state) => const MaterialPage(
                  child: DirectoryPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePath.profile.path,
                pageBuilder: (context, state) => const MaterialPage(
                  child: ProfilePage(),
                ),
              ),
            ],
          )
        ],
      )
    ],
  );
});
