import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_prova_target_sistemas/http/http_client.dart';
import 'package:flutter_prova_target_sistemas/repositories/user_repository.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login_store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  static final _formKey = GlobalKey<FormState>();
  final Uri _url = Uri.parse('https://google.com.br');
  final userRepository = UserRepository(client: HttpClient());
  late LoginStore _loginStore;

  @override
  void initState() {
    super.initState();
    _loginStore = LoginStore();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void clearErrorMessage() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw Exception('Não foi possível carregar $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Observer(
        builder: (context) {
          if (_loginStore.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            height: size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1e4e62),
                  Color(0xFF1f4f63),
                  Color(0xFF2c8687),
                  Color(0xFF2d958e),
                ],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Usuário",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextFormField(
                            onTapOutside: (event) =>
                                FocusScope.of(context).unfocus(),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20),
                            ],
                            cursorColor: Colors.black,
                            controller: _emailController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Senha",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            TextFormField(
                              onTapOutside: (event) =>
                                  FocusScope.of(context).unfocus(),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(20),
                              ],
                              cursorColor: Colors.black,
                              obscureText: true,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                errorStyle: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Informe sua senha';
                                } else if (!RegExp(r'^[a-zA-Z0-9]+$')
                                    .hasMatch(value)) {
                                  return 'Sua senha não pode conter caracteres especiais';
                                } else if (value.length < 2) {
                                  return 'Sua senha deve ter no mínimo 2 caracteres';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 180,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () async {
                            final login = _emailController.text;
                            final password = _passwordController.text;

                            if (login.isEmpty || password.isEmpty) {
                              showErrorMessage('Preencha ambos os campos');
                              return;
                            } else if (login.endsWith(' ') ||
                                password.endsWith(' ')) {
                              showErrorMessage('Campos com espaço no final');
                              return;
                            }
                            try {
                              _loginStore.setLoading(true);
                              final authenticated = await userRepository
                                  .authenticateUser(login, password);
                              if (authenticated) {
                                clearErrorMessage();
                                if (mounted) {
                                  Navigator.pushReplacementNamed(
                                      context, '/infoPage');
                                }
                              } else if (authenticated == false) {
                                showErrorMessage('Credencial inválida');
                                return;
                              }
                            } finally {
                              _loginStore.setLoading(false);
                            }
                          },
                          child: const Text(
                            "Entrar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: GestureDetector(
                    onTap: () {
                      _launchUrl();
                    },
                    child: const Text(
                      'Política de Privacidade',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
