import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

/// [PhonesNumberField] is used to get the user's phone number.
/// It is used in the [LoginScreen].
class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    Key? key,
    required this.onPhoneNumberChange,
    this.initialValue,
    this.readOnly = false,
    this.initialCountryCode,
  }) : super(key: key);
  final void Function(PhoneNumber number) onPhoneNumberChange;
  final String? initialValue;
  final bool readOnly;
  final String? initialCountryCode;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      initialCountryCode: initialCountryCode,
      keyboardType: TextInputType.phone,
      readOnly: readOnly,
      decoration: InputDecoration(
        counterText: "",
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.5, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(),
        ),
      ),
      textInputAction: TextInputAction.done,
      onChanged: (phoneNumber) => onPhoneNumberChange(phoneNumber),
      initialValue: initialValue,
    );
  }
}
