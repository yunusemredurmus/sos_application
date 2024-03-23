import 'package:sos_application/feature/credential/dto/user_dto.dart';

class AppUserManager {
  static final AppUserManager _instance = AppUserManager._init();

  factory AppUserManager() {
    return _instance;
  }

  AppUserManager._init();

  UserDto? user;
}
