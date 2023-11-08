import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:kydrem_whatsapp/core/utils/email_utils.dart';
import 'package:kydrem_whatsapp/features/signup/presentation/signup/validators/signup_validators.dart';

class SignupValidatorsImpl implements SignupValidators {
  @override
  String? Function(String? p1)? validateConfirmPassword(String? password) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
          errorText: 'A confirmação de senha deve ser preenchida'),
      FormBuilderValidators.minLength(4,
          errorText: 'A confirmação de senha deve ter no mínimo 4 caracteres'),
      (confirmPassword) {
        if (confirmPassword != password) {
          return 'As senhas não conferem';
        }
        return null;
      }
    ]);
  }

  @override
  String? Function(String? p1)? validateEmail() {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: 'O email deve ser preenchido'),
      (email) {
        if (email != null && !EmailUtils.isValidEmail(email)) {
          return 'Email inválido';
        }
        return null;
      }
    ]);
  }

  @override
  String? Function(String? p1)? validateName() {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: 'O nome deve ser preenchido'),
      FormBuilderValidators.minLength(4,
          errorText: 'O nome deve ter no mínimo 4 caracteres'),
    ]);
  }

  @override
  String? Function(String? p1)? validatePassword() {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: 'A senha deve ser preenchida'),
      FormBuilderValidators.minLength(4,
          errorText: 'A senha deve ter no mínimo 4 caracteres'),
    ]);
  }

  @override
  String? Function(String? p1)? validateUsername() {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
          errorText: 'O usuário deve ser preenchido'),
      FormBuilderValidators.minLength(4,
          errorText: 'O usuário deve ter no mínimo 4 caracteres'),
    ]);
  }
}
