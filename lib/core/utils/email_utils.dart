class EmailUtils {
  static bool isValidEmail(String email) {
    String pattern = _emailRegex();
    RegExp regExp = RegExp(pattern);
    if (email.isEmpty) {
      return false;
    }
    return regExp.hasMatch(email.replaceAll(' ', ''));
  }

  static _emailRegex() {
    return r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  }
}
