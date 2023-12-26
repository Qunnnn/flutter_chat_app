import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    this.inputDecoration,
    this.textEditingController,
    this.isPassWord = false,
    this.labelText,
    this.prefixIcon,
    this.onSaved,
    this.keyboardType,
    this.isEmailType = false,
    this.validator,
    this.autocorrect = true,
    this.obscureText = false,
  });

  final InputDecoration? inputDecoration;
  final TextEditingController? textEditingController;
  final bool isPassWord;
  final bool isEmailType;
  final Widget? prefixIcon;
  final String? labelText;
  final Function(String?)? onSaved;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool autocorrect;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: textEditingController,
      obscureText: isPassWord == true ? true : obscureText,
      autocorrect: autocorrect,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        labelText: labelText,
        prefixIcon: prefixIcon,
      ),
      validator: validator ??
          (String? value) {
            if (value == null || value.trim().isEmpty) {
              return isPassWord
                  ? 'Password required'
                  : isEmailType
                      ? 'Email required'
                      : 'Name required';
            }
            if (isPassWord) {
              if (value.trim().length < 6) {
                return 'Password must be at least 6 characters';
              }
            } else if (isEmailType) {
              if (!isEmail(value.trim())) {
                return 'Enter a valid email';
              }
            } else {
              if (value.trim().length < 2) {
                return 'Name must be at least 2 characters';
              }
            }
            return null;
          },
      onSaved: onSaved,
    );
  }
}
