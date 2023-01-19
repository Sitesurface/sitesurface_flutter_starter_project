import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final bool isAuthenticated;
  final String? phoneNumber;
  final String? otp;
  final bool error;
  final String? errorCode;
  final String? resendText;
  final bool canResendOtp;
  final bool requiresRecentLogin;
  const AuthState({
    required this.isAuthenticated,
    this.phoneNumber,
    this.otp,
    required this.error,
    this.errorCode,
    this.resendText,
    required this.canResendOtp,
    required this.requiresRecentLogin,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    String? phoneNumber,
    String? otp,
    bool? error,
    String? errorCode,
    String? resendText,
    bool? canResendOtp,
    bool? requiresRecentLogin,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
      error: error ?? this.error,
      errorCode: errorCode ?? this.errorCode,
      resendText: resendText ?? this.resendText,
      canResendOtp: canResendOtp ?? this.canResendOtp,
      requiresRecentLogin: requiresRecentLogin ?? this.requiresRecentLogin,
    );
  }

  @override
  List<Object?> get props {
    return [
      isAuthenticated,
      phoneNumber,
      otp,
      error,
      errorCode,
      resendText,
      canResendOtp,
      requiresRecentLogin,
    ];
  }
}
