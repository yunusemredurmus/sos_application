import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sos_application/core/router/router.dart';
import 'package:sos_application/core/utils/app_user_manager.dart';
import 'package:sos_application/feature/credential/provider/credential_provider.dart';

FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
  final user = AppUserManager().user;
  final loggedIn = user != null;

  if (!loggedIn) {
    return RoutePath.login.path;
  } else {
    return RoutePath.home.path;
  }
}
