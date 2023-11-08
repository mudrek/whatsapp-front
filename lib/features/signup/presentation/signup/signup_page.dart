import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/core/design/widgets/app_bar_transparent.dart';
import 'package:kydrem_whatsapp/core/design/widgets/app_button.dart';
import 'package:kydrem_whatsapp/core/design/widgets/app_message_dialog.dart';
import 'package:kydrem_whatsapp/core/design/widgets/app_text_form_field.dart';
import 'package:kydrem_whatsapp/core/shared/entities/user.dart';
import 'package:kydrem_whatsapp/features/signup/presentation/signup/atoms/signup_atom.dart';
import 'package:kydrem_whatsapp/features/signup/presentation/signup/states/signup_state.dart';
import 'package:kydrem_whatsapp/features/signup/presentation/signup/validators/signup_validators.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _usernameTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _confirmPasswordTextEditingController =
      TextEditingController();

  final SignupValidators _validators = Modular.get<SignupValidators>();
  final _formKey = GlobalKey<FormState>();
  get _isValid => _formKey.currentState?.validate();

  @override
  Widget build(BuildContext context) {
    context.select(() => [doSignupUser, signupStates]);

    final signupStateValue = signupStates.value;

    final isLoading = signupStateValue is LoadingSignupState;

    if (signupStateValue is ErrorSignupState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppMessageDialog(
          title: 'Falha ao criar a conta',
          message: signupStateValue.whatsappException.msg,
        ).show(context);
      });
    } else if (signupStateValue is SuccessSignupState) {
      debugPrint('CONTA CRIADA');
      // Modular.to.pushNamed('./');
    }

    return Scaffold(
      appBar: const AppBarTransparent(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Vamos criar sua conta',
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 32),
                AppTextFormField(
                  controller: _nameTextEditingController,
                  validator: _validators.validateName(),
                  labelText: 'Nome',
                ),
                const SizedBox(height: 16),
                AppTextFormField(
                  controller: _emailTextEditingController,
                  validator: _validators.validateEmail(),
                  labelText: 'Email',
                ),
                const SizedBox(height: 16),
                AppTextFormField(
                  controller: _usernameTextEditingController,
                  validator: _validators.validateUsername(),
                  labelText: 'Usuário',
                ),
                const SizedBox(height: 16),
                AppTextFormField(
                  controller: _passwordTextEditingController,
                  validator: _validators.validatePassword(),
                  labelText: 'Senha',
                ),
                const SizedBox(height: 16),
                AppTextFormField(
                  controller: _confirmPasswordTextEditingController,
                  validator: (value) => _validators
                      .validateConfirmPassword(
                        _passwordTextEditingController.text,
                      )
                      ?.call(value),
                  labelText: 'Confirme sua senha',
                ),
                const SizedBox(height: 32),
                AppButton(
                  text: 'Cadastrar',
                  onPressed: _onClickSignup,
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onClickSignup() {
    if (_isValid) {
      doSignupUser.setValue(
        User(
          name: _nameTextEditingController.text,
          username: _usernameTextEditingController.text,
          email: _emailTextEditingController.text,
          password: _passwordTextEditingController.text,
        ),
      );
    }
  }

  @override
  void dispose() {
    setInitialStatesSignupAtoms();

    super.dispose();
  }
}
