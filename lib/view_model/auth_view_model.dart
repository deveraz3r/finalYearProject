import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/otp_model.dart';
import '../utils/timer_utils.dart';

class AuthViewModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TimerUtils _timerUtils = TimerUtils();

  bool _isLoading = false;
  String _message = '';
  OTPModel? _otpModel;

  bool get isLoading => _isLoading;
  String get message => _message;
  OTPModel? get otpModel => _otpModel;

  /// Generates a random 6-digit OTP
  String _generateOTP() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  /// Sends a password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    if (email.isEmpty) {
      _message = 'Please enter your email.';
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await _auth.sendPasswordResetEmail(email: email);
      _message = 'We have sent you a password reset link.';
    } catch (e) {
      _message = 'Error: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Sends OTP for verification
  void sendOTP(String email) {
    String otp = _generateOTP();
    _otpModel = OTPModel(email: email, otp: otp);
    _message = 'OTP sent to your email!';

    print('OTP: $otp'); // Debugging purpose
    _startCountdown();
    notifyListeners();
  }

  /// Starts the timer countdown
  void _startCountdown() {
    _timerUtils.startTimer((seconds) {
      _otpModel = _otpModel?.copyWith(secondsRemaining: seconds);
      notifyListeners();
    }, () {
      _otpModel = _otpModel?.copyWith(isResendAvailable: true);
      notifyListeners();
    });
  }

  /// Resends the OTP
  void resendOTP() {
    if (_otpModel != null) {
      sendOTP(_otpModel!.email);
    }
  }

  /// Validates the OTP
  bool validateOTP(String enteredOTP) {
    return enteredOTP == _otpModel?.otp;
  }

  @override
  void dispose() {
    _timerUtils.cancelTimer();
    super.dispose();
  }
}
