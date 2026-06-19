class OtpVerificationScreenArgs {
  const OtpVerificationScreenArgs({
    required this.phoneNumber,
    required this.verificationId,
  });

  final String phoneNumber;
  final String verificationId;
}
