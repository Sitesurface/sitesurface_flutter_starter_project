import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sitesurface_flutter_starter_project/l10n/l10n.dart';
import 'package:sitesurface_flutter_starter_project/util/styles/theme/theme_ext.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../constants/assets/asset_constants.dart';
import '../../../util/asset_helper/asset_helper.dart';
import '../../../widgets/buttons/rounded_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.authBloc});
  static const id = '/otp';
  final AuthBloc authBloc;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otp;

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final size = MediaQuery.of(context).size;
    final locale = context.l10n;
    final authBloc = widget.authBloc;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SingleChildScrollView(
            child: BlocBuilder<AuthBloc, AuthState>(
              bloc: authBloc,
              builder: (context, state) {
                return Column(
                  children: [
                    AssetHelper(
                      image: AssetConstants.lottieOtp,
                      height: size.height * 0.3,
                      width: size.width,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 55,
                    ),
                    Text(
                      locale.verifyPhoneNumber,
                      style: textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${locale.verificationMessage}"
                      "\n${state.phoneNumber}",
                      style: textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    PinFieldAutoFill(
                      decoration: BoxLooseDecoration(
                        textStyle: textTheme.headline6,
                        strokeColorBuilder:
                            FixedColorBuilder(Colors.black.withOpacity(0.3)),
                      ),
                      currentCode: otp,
                      cursor: Cursor(color: colorScheme.primary),
                      autoFocus: true,
                      onCodeSubmitted: (code) {
                        otp = code;
                      },
                      onCodeChanged: (code) {
                        if (code?.length == 6) {
                          FocusScope.of(context).requestFocus(FocusNode());
                        }
                        if (code != null && code != "") {
                          otp = code;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            if (state.canResendOtp) {
                              authBloc.resendOtp();
                            }
                          },
                          child: Text(state.resendText ?? "",
                              style: textTheme.bodyMedium),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    RoundedButton(
                      label: locale.continuetxt,
                      onPressed: () {
                        if (otp == null) {
                          return;
                        }
                        authBloc.verifyOTP(otp!);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
