import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sos_application/feature/credential/provider/credential_provider.dart';

void authPage(BuildContext context) {
  final CredentialProvider credentialProvider = CredentialProvider();

  showModalBottomSheet(
      context: context,
      builder:  (BuildContext context) {
        int _currentIndex = 0;
        List<Map> screens = [
          {
            "title": "Hesap Oluştur",
          },
          {
            "title": "Giriş Yap",
          },
        ];
        return StatefulBuilder(
          builder: (context, setState) {
            return Consumer(
                builder: (context, provider, child) => Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      padding: const EdgeInsets.all(16.0),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              for (var i = 0; i < screens.length; i++)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _currentIndex = i;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 16),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: _currentIndex == i
                                              ? Colors.black
                                              : Colors.transparent,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      screens[i]['title']!,
                                      style: TextStyle(
                                        fontFamily: "BentonSans",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: _currentIndex == i
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const Gap(20),
                          if (_currentIndex == 0)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: credentialProvider.nameController,
                                  decoration: const InputDecoration(
                                    labelText: "Adınız",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const Gap(20),
                                TextField(
                                  controller:
                                      credentialProvider.surnameController,
                                  decoration: const InputDecoration(
                                    labelText: "Soyadınız",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const Gap(20),
                                TextField(
                                  controller: credentialProvider
                                      .registerEmailController,
                                  decoration: const InputDecoration(
                                    labelText: "Eposta Adresi",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const Gap(20),
                                TextField(
                                  obscureText: true,
                                  controller: credentialProvider
                                      .registerPasswordController,
                                  decoration: const InputDecoration(
                                    labelText: "Şifre",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const Gap(20),
                                ElevatedButton(
                                  onPressed: () {
                                    try {
                                      credentialProvider.register(context);
                                      context.go('/profile');
                                    } catch (e) {
                                      print('Error during registration: $e');
                                      // Handle the error as needed
                                    }
                                  },
                                  child: const Text("Kayıt Ol"),
                                ),
                              ],
                            ),
                          if (_currentIndex == 1)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextField(
                                  controller:
                                      credentialProvider.loginEmailController,
                                  decoration: const InputDecoration(
                                    labelText: "Eposta Adresi",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const Gap(20),
                                TextField(
                                  obscureText: true,
                                  controller: credentialProvider
                                      .loginPasswordController,
                                  decoration: const InputDecoration(
                                    labelText: "Şifre",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const Gap(20),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("Giriş Yap"),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ));
          },
        );
      });
}
