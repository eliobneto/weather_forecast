import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:weather_forecast/core/api/get_it.dart';
import 'package:weather_forecast/core/definitions/constraints.dart';
import 'package:weather_forecast/core/definitions/context.dart';
import 'package:weather_forecast/core/definitions/palette.dart';
import 'package:weather_forecast/core/definitions/paths.dart';
import 'package:weather_forecast/core/widgets/card_widget.dart';
import 'package:weather_forecast/core/widgets/dialog_widget.dart';
import 'package:weather_forecast/core/widgets/elevated_button_widget.dart';
import 'package:weather_forecast/core/widgets/no_glow_widget.dart';
import 'package:weather_forecast/features/auth/view/blocs/auth_credentials/auth_credentials_cubit.dart';
import 'package:weather_forecast/features/auth/view/blocs/auth_cubit/auth_cubit.dart';
import 'package:weather_forecast/features/auth/view/widgets/login_form_widget.dart';
import 'package:weather_forecast/features/auth/view/widgets/login_loading_form_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final key = GlobalKey<LoginFormWidgetState>();
  final buttonKey = GlobalKey();

  late final AuthCubit authCubit;
  late final AuthCredentialsCubit authCredentialsCubit;

  @override
  void initState() {
    super.initState();

    authCubit = getIt<AuthCubit>();
    authCredentialsCubit = getIt<AuthCredentialsCubit>()..getCredentials();
  }

  void _submit() => key.currentState?.submit();

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthCubit, AuthState>(
    bloc: authCubit,
    listenWhen: (prev, cur) =>
        prev is AuthLoadingState &&
        (cur is AuthFailState || cur is AuthSuccessState),
    listener: (context, state) {
      if (state is AuthFailState) {
        DialogWidget(
          title: 'Fail to login',
          subtitle: state.error.message,
        ).show(context);

        return;
      }

      if (state is AuthSuccessState) {
        Navigator.of(context).pushNamed('/weather');
      }
    },
    builder: (context, state) => Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Paths.loginBackground),
              fit: BoxFit.cover,
            ),
          ),
        ),
        GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Palette.transparent,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(Constraints.paddingLarge),
                  child:
                      BlocBuilder<AuthCredentialsCubit, AuthCredentialsState>(
                        bloc: authCredentialsCubit,
                        builder: (context, credentialsState) => CardWidget(
                          constraints: const BoxConstraints(maxWidth: 450.0),
                          child: NoGlowWidget(
                            child: SingleChildScrollView(
                              physics: const ClampingScrollPhysics(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxWidth: 250.0,
                                    ),
                                    child: Text(
                                      'Authentication',
                                      style: context.textTheme.titleLarge,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: Constraints.spacerNormal,
                                  ),
                                  if (credentialsState
                                      is AuthCredentialsSuccessState) ...[
                                    LoginFormWidget(
                                      key: key,
                                      buttonKey: buttonKey,
                                      credentials: credentialsState.credentials,
                                      onPressed: (email, password, save) =>
                                          authCubit.login(
                                            email: email,
                                            password: password,
                                            saveCredentials: save,
                                          ),
                                    ),
                                  ] else ...[
                                    const LoginLoadingFormWidget(),
                                  ],
                                  const SizedBox(
                                    height: Constraints.spacerLarge,
                                  ),
                                  SizedBox(
                                    width: context.mediaSize.width / 2.0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: Constraints.paddingLarge,
                                      ),
                                      child: ElevatedButtonWidget(
                                        onPressed: _submit,
                                        enabled: state is! AuthLoadingState,
                                        isLoading: state is AuthLoadingState,
                                        label: 'Login',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: Constraints.spacerNormal,
                                  ),
                                  FutureBuilder<PackageInfo>(
                                    future: PackageInfo.fromPlatform(),
                                    builder: (context, snapshot) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: Constraints.paddingNormal,
                                      ),
                                      child: Text(
                                        snapshot.hasData
                                            ? 'v${snapshot.data?.version}'
                                            : '',
                                        textAlign: TextAlign.center,
                                        style: context.textTheme.bodySmall
                                            ?.copyWith(
                                              fontSize:
                                                  Constraints.fontSizeSmaller,
                                              color: Palette.darkGrey,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
