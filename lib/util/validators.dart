class Validators {
  /// pass the static functions as tear-off in validator of textfield [Validators.email]
  /// ```dart
  ///  CustomTextField(
  ///   label: "CM No.",
  ///   maxLength: 30,
  ///   validator: Validators.email,
  ///   onChanged: (value) {
  ///  cmNo = value;
  ///    }),
  /// ```
  /// if you want to pass custom message then create object and call function [Validators("Custom message").simple]
  /// ```dart
  ///  CustomTextField(
  ///   label: "CM No.",
  ///   maxLength: 30,
  ///   validator: Validators("Enter CM No.").simple,
  ///   onChanged: (value) {
  ///   cmNo = value;
  ///    }),
  /// ```
  Validators(this.message);

  final String? message;

  static String? email(String? value) {
    const pattern =
        r'(^[a-zA-Z\u0900-\u097F0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
    final regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return "This field is required";
    } else if (!regExp.hasMatch(value)) {
      return "Enter a valid email address";
    } else {
      return null;
    }
  }

  static String? name(String? value) {
    String patttern = r'(^[a-zA-Z\u0900-\u097F ]*$)';
    RegExp regExp = RegExp(patttern);
    if (value == null || value.isEmpty) {
      return "This field is required";
    } else if (!regExp.hasMatch(value)) {
      return "Name should not include special characters";
    } else {
      return null;
    }
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    } else if (value.length < 8) {
      return "Password should have atleast 8 characters";
    } else {
      return null;
    }
  }
  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    } else if (value.length < 8) {
      return "Password should have atleast 8 characters";

    } else if (value!=password) {
      return "Passwords dont match";
    } else {
      return null;
    }
  }

  static String? phone(String? value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (value == null || value.isEmpty) {
      return "This field is required";
    } else if (!regExp.hasMatch(value)) {
      return "Enter a valid phone number";
    }
    return null;
  }

  ///validates whether entered string is not null and not empty with custom [message]
  String? simple(String? value) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  static String? simpleText(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    } else {
      return null;
    }
  }

  static String? bankNumber(String? value) {
    String patttern = r'(^[0-9]{9,18}$)';
    RegExp regExp = RegExp(patttern);
    if (value == null || value.isEmpty) {
      return "Kindly enter account number";
    } else if (!regExp.hasMatch(value)) {
      return "Kindly enter correct account number";
    } else {
      return null;
    }
  }

  static String? ifsc(String? value) {
    String patttern = r'(^[A-Z]{4}0[A-Z0-9]{6}$)';
    RegExp regExp = RegExp(patttern);
    if (value == null || value.isEmpty) {
      return "Kindly enter ifsc code";
    } else if (!regExp.hasMatch(value)) {
      return "Kindly enter correct ifsc code";
    } else {
      return null;
    }
  }

  static String? pan(String? value) {
    String patttern = r'([A-Z]{5}[0-9]{4}[A-Z]{1})';
    RegExp regExp = RegExp(patttern);
    if (value == null || value.isEmpty) {
      return "Kindly enter pan number";
    } else if (!regExp.hasMatch(value)) {
      return "Kindly enter correct pan number";
    }
    return null;
  }

  static String? adhaar(String? value) {
    String patttern = r'(^[0-9]{12}$)';
    RegExp regExp = RegExp(patttern);
    if (value == null || value.isEmpty) {
      return "Kindly enter aadhaar number";
    } else if (!regExp.hasMatch(value)) {
      return "Kindly enter correct aadhaar number";
    }
    return null;
  }

  static String? number(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    } else if (int.tryParse(value) == null) {
      return "Please enter valid number";
    }
    return null;
  }

  //zipcode validation
  static String? zipCode(String? value) {
    String patttern = r'(^[0-9]{6}$)';
    RegExp regExp = RegExp(patttern);
    if (value == null || value.isEmpty) {
      return "This field is required";
    } else if (!regExp.hasMatch(value)) {
      return "Enter a valid zipcode";
    }
    return null;
  }
}
