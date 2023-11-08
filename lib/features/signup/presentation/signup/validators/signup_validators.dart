abstract class SignupValidators {
  String? Function(String?)? validateName();
  String? Function(String?)? validateEmail();
  String? Function(String?)? validateUsername();
  String? Function(String?)? validatePassword();
  String? Function(String?)? validateConfirmPassword(String? password);
}
