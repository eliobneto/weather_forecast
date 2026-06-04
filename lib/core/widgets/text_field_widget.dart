import 'package:weather_forecast/core/definitions/constraints.dart';
import 'package:weather_forecast/core/definitions/context.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    this.focusNode,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
    this.textAlign = TextAlign.start,
    this.autocorrect = true,
    this.obscureText = false,
    this.enabled = true,
    this.hintText,
    required this.labelText,
    this.inputStyle,
    this.hintStyle,
    this.labelStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.externalPadding = const EdgeInsets.all(Constraints.paddingSmaller),
    this.readOnly,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final VoidCallback? onTap;
  final ValueSetter<String>? onChanged;
  final ValueSetter<String>? onSubmitted;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final TextAlign textAlign;
  final bool autocorrect;
  final bool obscureText;
  final bool enabled;
  final bool? readOnly;
  final String? hintText;
  final String? labelText;
  final TextStyle? inputStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets? contentPadding;
  final EdgeInsets externalPadding;

  Widget? getIcon(Widget? icon) => icon == null
      ? null
      : Padding(
          padding: const EdgeInsets.only(right: Constraints.paddingSmaller),
          child: icon,
        );

  @override
  Widget build(BuildContext context) => Padding(
    padding: externalPadding,
    child: TextFormField(
      readOnly: readOnly ?? false,
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      autovalidateMode: autovalidateMode,
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      textAlign: textAlign,
      autocorrect: autocorrect,
      obscureText: obscureText,
      enabled: enabled,
      style: inputStyle ?? context.textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: hintText ?? labelText,
        labelText: labelText,
        hintStyle: hintStyle,
        labelStyle: labelStyle,
        counterText: '',
        prefixIcon: getIcon(prefixIcon),
        suffixIcon: getIcon(suffixIcon),
        contentPadding: contentPadding,
      ),
    ),
  );
}
