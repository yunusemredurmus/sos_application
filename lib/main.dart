import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos_application/core/router/router.dart';
import 'package:sos_application/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      routerConfig: ref.read(routeProvider),
    );
  }
}

class Root extends StatelessWidget {
  const Root({super.key, required this.shell});
  final StatefulNavigationShell shell;

  void goBranch(int index) {
    shell.goBranch(index, initialLocation: index == shell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: goBranch,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_rounded),
            label: 'Anasayfa',
          ),
          NavigationDestination(
            icon: Icon(Icons.directions_ferry_rounded),
            label: 'Profil',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_off_outlined),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
