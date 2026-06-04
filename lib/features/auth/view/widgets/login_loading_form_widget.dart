import 'package:flutter/material.dart';
import 'package:weather_forecast/core/definitions/constraints.dart';
import 'package:weather_forecast/core/definitions/context.dart';
import 'package:weather_forecast/core/definitions/palette.dart';
import 'package:weather_forecast/core/widgets/text_field_widget.dart';

class LoginLoadingFormWidget extends StatelessWidget {
  const LoginLoadingFormWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      TextFieldWidget(
        controller: TextEditingController(),
        prefixIcon: const Icon(Icons.account_circle, color: Palette.darkGrey),
        enabled: false,
        labelText: 'Email',
      ),
      const SizedBox(height: Constraints.spacerSmaller),
      TextFieldWidget(
        controller: TextEditingController(),
        prefixIcon: const Icon(Icons.lock, color: Palette.darkGrey),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.visibility_off_outlined,
            color: Palette.darkGrey,
          ),
          splashColor: Palette.transparent,
        ),
        enabled: false,
        labelText: 'Password',
      ),
      const SizedBox(height: Constraints.spacerSmaller),
      Row(
        children: [
          const Checkbox(value: true, onChanged: null),
          Text('Remember me', style: context.textTheme.bodySmall),
        ],
      ),
    ],
  );
}
