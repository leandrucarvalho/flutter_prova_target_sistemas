import 'package:flutter/material.dart';
import 'package:flutter_prova_target_sistemas/pages/login_page.dart';
import 'package:flutter_prova_target_sistemas/repositories/user_repository.dart';

import 'http/http_client.dart';
import 'pages/info_page.dart';

import 'package:provider/provider.dart';

void main() {
  final httpClient = HttpClient();
  runApp(
    MultiProvider(
      providers: [
        Provider<UserRepository>(
          create: (context) => UserRepository(client: httpClient),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/infoPage': (context) => const InfoPage(),
      },
    );
  }
}
