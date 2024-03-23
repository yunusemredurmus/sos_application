import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sos_application/feature/credential/dto/user_dto.dart';
import 'package:sos_application/feature/credential/services/i_auth_service.dart';

class AuthService implements IAuthService {
  @override
  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {}
      return null;
    }
  }

  @override
  Future<UserCredential?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<UserCredential> changePasswords(
      String email, String oldPassword, String newPassword) async {
    final User user = FirebaseAuth.instance.currentUser!;
    final AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: oldPassword,
    );
    return user.reauthenticateWithCredential(credential).then((value) {
      return user.updatePassword(newPassword).then((value) {
        return FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: newPassword,
        );
      });
    });
  }

  @override
  Future<UserDto?> getCurrentUser() async {
    try {
      // Kullanıcı yoksa null döndür
      if (FirebaseAuth.instance.currentUser == null) {
        return null;
      }

      final QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection('users')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
          .get();
      // Veri bulunamazsa veya boşsa null döndür
      if (data.docs.isEmpty) {
        return null;
      }

      // Kullanıcı verilerini al ve UserDto'ya dönüştür
      final user = data.docs.first.data();
      return UserDto.fromMap(user);
    } catch (e) {
      // Hata durumunda null döndür
      print('Hata oluştu: $e');
      return null;
    }
  }

  @override
  Future<void> saveUserData(UserDto user) async {
    FirebaseFirestore.instance.collection('users').add(user.toMap());
  }
}
