import 'package:firebase_auth/firebase_auth.dart';
import 'package:sos_application/feature/credential/dto/user_dto.dart';

abstract class IAuthService {
  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password);

  Future<UserCredential?> signUpWithEmailAndPassword(String email, String password);

  Future<void> signOut();

  Future<UserCredential> changePasswords(
      String email, String oldPassword, String newPassword);

  Future<UserDto?> getCurrentUser();

  Future<void> saveUserData(UserDto userDto);
}
