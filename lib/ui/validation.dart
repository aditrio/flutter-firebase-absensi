class Validation {
  String emailValidation(String val) {
    if (!val.contains('@')) {
      return "Format email salah !";
    }

    return null;
  }

  String passValidation(String val) {
    if (val.length < 4) {
      return "Password minimal 4 karakter !";
    }

    return null;
  }
}
