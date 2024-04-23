extension ValidationExtension on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9._]+@[a-zA-Z0-9-]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp = RegExp(r'^[A-Za-z ]+$');
    return nameRegExp.hasMatch(this);
  }

  /// Note : This code will vary as per project requirement.
  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$");
    return passwordRegExp.hasMatch(this);
  }

  /// Note : This validation is as per Indian Mobile Number format.
  /// Note : This code will vary as per project requirement.
  bool get isValidMobile {
    final phoneRegExp = RegExp(r"^[0123456789]{1}\d{7}");
    return phoneRegExp.hasMatch(this);
  }

  bool get isAllowNumberCharacter {
    final emailRegExp = RegExp(r"[0-9A-Za-z]$");
    return emailRegExp.hasMatch(this);
  }
}
