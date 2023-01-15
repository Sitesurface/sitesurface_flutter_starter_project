import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:sitesurface_flutter_starter_project/constants/assets/lottie_constants.dart';
import 'package:sitesurface_flutter_starter_project/l10n/l10n.dart';
import 'package:sitesurface_flutter_starter_project/util/styles/theme/theme_ext.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../cache/prefs_constant.dart';
import '../../../cache/shared_preferences.dart';
import '../../../constants/assets/asset_constants.dart';
import '../../../util/asset_helper/lottie_helper.dart';
import '../../../util/validators.dart';
import '../../../widgets/buttons/rounded_button.dart';
import '../../../widgets/text_form_field/phone_text_field.dart';
import '../../../widgets/webview_screen.dart';
import '../../dashboard/dashboard.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../widgets/social_buttons.dart';
import '../../../widgets/text_form_field/text_field_header.dart';
import '../../../widgets/text_form_field/text_form_field.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const id = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isEmailSignIn = false;
  String? email;
  String? password;
  String? phoneNumber;
  final _emailFormKey = GlobalKey<FormState>();
  final _phoneFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final size = MediaQuery.of(context).size;
    final locale = context.l10n;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Pref.instance.pref
                          .setBool(PrefConstant.authSkipped, true);
                      Navigator.pushReplacementNamed(context, Dashboard.id);
                    },
                    child: Text(
                      locale.skip,
                      style: textTheme.bodyText1!,
                    ),
                  ),
                ),
                Expanded(
                  child: BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {},
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          LottieAsset(
                              assetName: LottieConstants.login,
                              fit: BoxFit.contain,
                              height: size.height * 0.35,
                              width: size.width),
                          if (isEmailSignIn)
                            Form(
                                key: _emailFormKey,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextFieldHeader(
                                        title: locale.email,
                                      ),
                                    ),
                                    CTextField(
                                      onChanged: (value) {
                                        email = value;
                                      },
                                      label: locale.email,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: Validators.email,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextFieldHeader(
                                        title: locale.password,
                                      ),
                                    ),
                                    CTextField(
                                      onChanged: (value) {
                                        password = value;
                                      },
                                      label: locale.password,
                                      isPasswordField: true,
                                      validator: Validators.password,
                                    ),
                                    RoundedButton(
                                      label: locale.loginSignUp,
                                      onPressed: () async {
                                        if (_emailFormKey.currentState!
                                            .validate()) {
                                          await context
                                              .read<AuthBloc>()
                                              .emailLogin(
                                                  emailAddress: email!,
                                                  password: password!);
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(
                                        onPressed: () async {
                                          //dialog to enter email
                                          String? resetEmail;
                                          await showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text(
                                                locale.enterEmail,
                                              ),
                                              content: CTextField(
                                                onChanged: (value) {
                                                  resetEmail = value;
                                                },
                                                label: locale.email,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                validator: Validators.email,
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(locale.cancel),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                    await context
                                                        .read<AuthBloc>()
                                                        .forgetPassword(
                                                            resetEmail!);
                                                  },
                                                  child: Text(locale.reset),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Text(
                                          locale.forgetPassword,
                                          style: textTheme.bodyMedium,
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                          else
                            Form(
                                key: _phoneFormKey,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextFieldHeader(
                                        title: locale.phoneNumber,
                                      ),
                                    ),
                                    PhoneTextField(
                                        onPhoneNumberChange: (PhoneNumber num) {
                                      phoneNumber =
                                          "${num.countryCode}${num.number}";
                                    }),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    RoundedButton(
                                        label: locale.getOtp,
                                        onPressed: () async {
                                          var navigator = Navigator.of(context);
                                          var route = context.read<AuthBloc>();
                                          if (_phoneFormKey.currentState!
                                              .validate()) {
                                            await SmsAutoFill().listenForCode();
                                            navigator.pushNamed(OtpScreen.id);
                                            route.phoneNumberSignIn(
                                                phoneNumber ?? "");
                                          }
                                        }),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("or login with...",
                              style: textTheme.labelMedium),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SocialButton(
                                assetName: AssetConstants.googlelogo,
                                onPressed: () async {
                                  await context.read<AuthBloc>().googleLogin();
                                },
                              ),
                              SocialButton(
                                assetName: AssetConstants.facebooklogo,
                                onPressed: () async {
                                  await context
                                      .read<AuthBloc>()
                                      .signInWithFacebook();
                                },
                              ),
                              if (Platform.isIOS)
                                SocialButton(
                                  assetName: AssetConstants.applelogo,
                                  onPressed: () async {
                                    await context
                                        .read<AuthBloc>()
                                        .appleSignin();
                                  },
                                ),
                              SocialButton(
                                assetName: isEmailSignIn
                                    ? AssetConstants.phonelogo
                                    : AssetConstants.emaillogo,
                                onPressed: () {
                                  setState(() {
                                    isEmailSignIn = !isEmailSignIn;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: locale.byContinuingUagree,
                          style: textTheme.bodyMedium,
                          children: [
                            TextSpan(
                                text: locale.privacyPolicy,
                                style: textTheme.bodyMedium?.copyWith(
                                    decoration: TextDecoration.underline,
                                    color: colorScheme.primary),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    var constant = context.read<ConstantBloc>();
                                    String uri = constant.state.constants
                                            ?.setting?.privacyPolicy ??
                                        '';
                                    Navigator.pushNamed(
                                      context,
                                      WebViewScreen.id,
                                      arguments: WebViewData(
                                        title: locale.privacyPolicy,
                                        url: uri,
                                      ),
                                    );
                                  }),
                            TextSpan(
                              text: " ${locale.and}\n",
                              style: textTheme.bodyMedium,
                            ),
                            TextSpan(
                              text: locale.termsAndConditions,
                              style: textTheme.bodyMedium?.copyWith(
                                  decoration: TextDecoration.underline,
                                  color: colorScheme.primary),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  var constant = context.read<ConstantBloc>();
                                  String uri = constant.state.constants?.setting
                                          ?.termsAndConditions ??
                                      '';
                                  Navigator.pushNamed(
                                    context,
                                    WebScreen.id,
                                    arguments: WebViewData(
                                      title: locale.termsAndConditions,
                                      url: uri,
                                    ),
                                  );
                                },
                            ),
                          ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
