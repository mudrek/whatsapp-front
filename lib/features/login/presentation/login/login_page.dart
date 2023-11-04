import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/features/login/domain/dtos/login_user_dto.dart';
import 'package:kydrem_whatsapp/features/login/presentation/login/atoms/login_atom.dart';
import 'package:kydrem_whatsapp/features/login/presentation/login/states/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.select(() => [doLogin, loginStates]);

    final loginStateValue = loginStates.value;

    final isLoading = loginStateValue is LoadingLoginState;

    if (loginStateValue is ErrorLoginState) {
    } else if (loginStateValue is SuccessLoginState) {
      Modular.to.pushNamed('./');
    }

    return Scaffold(
      body: Container(
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/images/login-background.jpeg'),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _usernameTextEditingController,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordTextEditingController,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 45,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _doLogin,
                    child: isLoading
                        ? const SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Entrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _doLogin() {
    doLogin.setValue(
      LoginUserDTO(
        username: _usernameTextEditingController.text,
        password: _passwordTextEditingController.text,
      ),
    );
  }
}
