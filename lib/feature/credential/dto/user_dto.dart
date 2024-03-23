// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sos_application/feature/credential/services/auth_service.dart';
import 'package:sos_application/feature/credential/services/i_auth_service.dart';

class UserDto {
  final String name;
  final String surname;
  final String bloodType;
  final String height;
  final String weight;
  final DateTime birthday;
  final String email;
  final String password;
  final String gender;

  UserDto({
    required this.name,
    required this.surname,
    required this.bloodType,
    required this.height,
    required this.weight,
    required this.birthday,
    required this.email,
    required this.password,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'surname': surname,
      'bloodType': bloodType,
      'height': height,
      'weight': weight,
      'birthday': birthday.millisecondsSinceEpoch,
    };
  }

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      name: map['name'] as String,
      surname: map['surname'] as String,
      bloodType: map['bloodType'] as String,
      height: map['height'] as String,
      weight: map['weight'] as String,
      birthday: DateTime.fromMillisecondsSinceEpoch(map['birthday'] as int),
      email: map['email'] as String,
      password: map['password'] as String,
      gender: map['gender'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDto.fromJson(String source) =>
      UserDto.fromMap(json.decode(source) as Map<String, dynamic>);

  static IAuthService get _authService => AuthService();

  static Future<UserCredential?> signUpWithEmailAndPassword(
      String email, String password) async {
    return await _authService.signUpWithEmailAndPassword(email, password);
  }

  static Future<void> signOut() async {
    await _authService.signOut();
  }

  static Future<UserDto?> getCurrentUser() async {
    return _authService.getCurrentUser();
  }

  static Future<UserCredential?> signIn(String email, String password) async {
    return _authService.signInWithEmailAndPassword(email, password);
  }

  Future<void> saveUserData() async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      await users.doc(users as String?).set({
        'email': email,
        'name': name,
        'surname': surname,
        'weight': weight,
        'height': height,
        'birthday': birthday,
        'gender': gender,
        'bloodType': bloodType,
      });
    } catch (e) {
      throw Exception('Error saving user data: $e');
    }
  }
}
