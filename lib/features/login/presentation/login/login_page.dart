import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/core/design/widgets/app_bar_transparent.dart';
import 'package:kydrem_whatsapp/core/design/widgets/app_button.dart';
import 'package:kydrem_whatsapp/core/design/widgets/app_message_dialog.dart';
import 'package:kydrem_whatsapp/core/design/widgets/app_text_form_field.dart';
import 'package:kydrem_whatsapp/features/login/domain/dtos/login_user_dto.dart';
import 'package:kydrem_whatsapp/features/login/presentation/login/atoms/login_atom.dart';
import 'package:kydrem_whatsapp/features/login/presentation/login/states/login_state.dart';
import 'package:kydrem_whatsapp/features/login/presentation/login/validators/login_validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  get _isValid => _formKey.currentState?.validate();

  final TextEditingController _usernameTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final LoginValidators _validators = Modular.get<LoginValidators>();

  @override
  Widget build(BuildContext context) {
    context.select(() => [doLogin, loginStates]);

    final loginStateValue = loginStates.value;

    final isLoading = loginStateValue is LoadingLoginState;

    if (loginStateValue is ErrorLoginState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppMessageDialog(
          title: 'Falha ao logar',
          message: loginStateValue.whatsappException.msg,
        ).show(context);
      });
    } else if (loginStateValue is SuccessLoginState) {
      debugPrint('LOGADO');
      Modular.to.pushNamedAndRemoveUntil(
        '/feed-chats/',
        ModalRoute.withName('/presenting'),
      );
    }

    return Scaffold(
      appBar: const AppBarTransparent(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vamos conectá-lo',
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Bem-vindo de volta',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                Column(
                  children: [
                    AppTextFormField(
                      controller: _usernameTextEditingController,
                      validator: _validators.validateUsername(),
                      labelText: 'Usuário',
                      focusNode: _usernameFocusNode,
                      nextFocus: _passwordFocusNode,
                    ),
                    const SizedBox(height: 16),
                    AppTextFormField(
                      labelText: 'Senha',
                      obscureText: true,
                      controller: _passwordTextEditingController,
                      validator: _validators.validatePassword(),
                      focusNode: _passwordFocusNode,
                      passwordEye: true,
                    ),
                  ],
                ),
                AppButton(
                  text: 'Entrar',
                  onPressed: _onClickLogin,
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onClickLogin() {
    if (_isValid) {
      doLogin.setValue(
        LoginUserDTO(
          username: _usernameTextEditingController.text,
          password: _passwordTextEditingController.text,
        ),
      );
    }
  }

  @override
  void dispose() {
    setInitialStatesLoginAtoms();
    super.dispose();
  }
}
