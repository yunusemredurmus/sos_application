import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sos_application/core/router/router.dart';
import 'package:sos_application/core/utils/app_user_manager.dart';
import 'package:sos_application/feature/credential/provider/credential_provider.dart';

FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
  CredentialProvider prov = CredentialProvider();

  final user = AppUserManager().user;

  final loggedIn = user != null;

  final login = state.matchedLocation == RoutePath.login.path;
  final splash = state.matchedLocation == RoutePath.splash.path;

  if (!loggedIn && login) return RoutePath.login.path;
  if (loggedIn && splash) return RoutePath.home.path;

  return null;
}
