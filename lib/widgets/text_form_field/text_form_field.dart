import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CTextField extends StatefulWidget {
  final void Function(String?) onChanged;
  final String label;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isPasswordField;
  final String? initialValue;
  const CTextField(
      {Key? key,
      required this.onChanged,
      required this.label,
      this.validator,
      this.keyboardType,
      this.isPasswordField = false,
      this.initialValue})
      : super(key: key);

  @override
  State<CTextField> createState() => _CTextFieldState();
}

class _CTextFieldState extends State<CTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        validator: widget.validator,
        onChanged: widget.onChanged,
        initialValue: widget.initialValue,
        obscureText: widget.isPasswordField ? obscureText : false,
        keyboardType: widget.keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        
        decoration: InputDecoration(
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: Icon(obscureText
                      ? MdiIcons.eyeOffOutline
                      : MdiIcons.eyeOutline))
              : null,
          helperText: ' ',
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14.5, horizontal: 12),
          labelText: widget.label,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: const OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
