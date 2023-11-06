import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:kydrem_whatsapp/features/login/presentation/login/validators/login_validators.dart';

class LoginValidatorsImpl implements LoginValidators {
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
