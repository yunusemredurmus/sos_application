import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos_application/core/utils/app_user_manager.dart';
import 'package:sos_application/core/utils/base_provider.dart';
import 'package:sos_application/feature/credential/dto/user_dto.dart';

final credentialProvider =
    ChangeNotifierProvider<CredentialProvider>((ref) => CredentialProvider());

class CredentialProvider extends BaseProvider {
  ///Login Controller
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  /// Register Controller
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  DateTime? birthday;
  TextEditingController genderController = TextEditingController();
  TextEditingController bloodTypeController = TextEditingController();

  void login(BuildContext context) async {
    final email = loginEmailController.text;
    final password = loginPasswordController.text;
    if (email.isNotEmpty && password.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Giriş yapılıyor...'),
        ),
      );
      setLoading(true);

      try {
        final UserCredential? userCredential =
            await UserDto.signIn(email, password);
        if (userCredential != null) {
          AppUserManager().user = await UserDto.getCurrentUser();
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$e')));
      } finally {
        setLoading(false);
      }
    }
    notifyListeners();
  }

  Future<void> register(BuildContext context) async {
    final email = registerEmailController.text;
    final password = registerPasswordController.text;
    final name = nameController.text;
    final surname = surnameController.text;
    final weight = weightController.text;
    final height = heightController.text;
    final gender = genderController.text;
    final bloodType = bloodTypeController.text;
    final birthday = this.birthday.toString();

    if (email.isNotEmpty && password.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Kayıt Oluşturuluyor"),
        ),
      );
      setLoading(true);

      try {
        // ignore: unused_local_variable
        final UserCredential? userCredential =
            await UserDto.signUpWithEmailAndPassword(email, password);

        UserDto newUser = UserDto(
          email: email,
          name: name,
          surname: surname,
          weight: weight,
          height: height,
          birthday: DateTime.parse(birthday),
          gender: gender,
          bloodType: bloodType,
          password: password,
        );

        await newUser.saveUserData();

        AppUserManager().user = newUser;
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Kayıt olurken hata: $e')));
      } finally {
        setLoading(false);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen boşlukları dolduralım.'),
        ),
      );
    }
    notifyListeners();
  }

  
}
