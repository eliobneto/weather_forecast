import 'package:flutter/material.dart';
import 'package:weather_forecast/core/definitions/constraints.dart';
import 'package:weather_forecast/core/definitions/context.dart';
import 'package:weather_forecast/core/definitions/palette.dart';
import 'package:weather_forecast/core/definitions/regex.dart';
import 'package:weather_forecast/core/widgets/text_field_widget.dart';
import 'package:weather_forecast/features/auth/domain/models/auth_model.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({
    super.key,
    required this.buttonKey,
    this.credentials,
    required this.onPressed,
  });

  final GlobalKey buttonKey;
  final AuthModel? credentials;
  final void Function(String, String, bool) onPressed;

  @override
  State<LoginFormWidget> createState() => LoginFormWidgetState();
}

class LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  late bool obscurePassword;
  late bool save;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController(
      text: widget.credentials != null && widget.credentials!.showCredentials
          ? widget.credentials!.email
          : null,
    );
    passwordController = TextEditingController(
      text: widget.credentials != null && widget.credentials!.showCredentials
          ? widget.credentials!.password
          : null,
    );

    obscurePassword = true;
    save = true;
  }

  Icon get passwordIcon => Icon(
    obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
    color: Palette.darkGrey,
  );

  void submit() async {
    FocusScope.of(context).unfocus();

    final valid = _formKey.currentState?.validate() ?? false;

    if (valid) {
      widget.onPressed(emailController.text, passwordController.text, save);
    }
  }

  @override
  Widget build(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      children: [
        TextFieldWidget(
          controller: emailController,
          validator: (value) =>
              value == null ||
                  value.isEmpty ||
                  !RegExp(Regex.emailRegex).hasMatch(value)
              ? 'Email required.'
              : null,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          prefixIcon: const Icon(Icons.account_circle, color: Palette.darkGrey),
          autocorrect: false,
          labelText: 'Email',
        ),
        const SizedBox(height: Constraints.spacerSmaller),
        TextFieldWidget(
          controller: passwordController,
          validator: (value) =>
              value == null || value.isEmpty ? 'Password required.' : null,
          keyboardType: TextInputType.visiblePassword,
          obscureText: obscurePassword,
          hintText: 'Password',
          labelText: 'Password',
          prefixIcon: const Icon(Icons.lock, color: Palette.darkGrey),
          suffixIcon: IconButton(
            onPressed: () => setState(() => obscurePassword = !obscurePassword),
            icon: passwordIcon,
            splashColor: Palette.transparent,
          ),
        ),
        const SizedBox(height: Constraints.spacerSmaller),
        Row(
          children: [
            Checkbox(
              value: save,
              activeColor: Palette.primary,
              side: const BorderSide(
                color: Palette.darkGrey,
                width: Constraints.spacerExtraSmall,
              ),
              onChanged: (_) => setState(() => save = !save),
            ),
            GestureDetector(
              onTap: () => setState(() => save = !save),
              child: Text('Remember me', style: context.textTheme.bodySmall),
            ),
          ],
        ),
      ],
    ),
  );
}
