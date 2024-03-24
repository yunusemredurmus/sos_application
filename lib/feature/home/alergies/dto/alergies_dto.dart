// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:sos_application/core/utils/app_user_manager.dart';

class AlergiesDto {
  final String id;
  final String name;
  final String photoUrl;
  final String user = AppUserManager().user!.email;

  AlergiesDto({required this.id, required this.name, required this.photoUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
    };
  }

  factory AlergiesDto.fromMap(Map<String, dynamic> map) {
    return AlergiesDto(
      id: map['id'] as String,
      name: map['name'] as String,
      photoUrl: map['photoUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AlergiesDto.fromJson(String source) =>
      AlergiesDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
