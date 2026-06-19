class ErrorMessageHelper {
  ErrorMessageHelper._();

  static String getMessage(dynamic error) {
    final message = error.toString().replaceFirst('Exception: ', '').trim();

    if (message.isEmpty) {
      return 'Something went wrong. Please try again.';
    }

    final lowerCaseMessage = message.toLowerCase();

    if (lowerCaseMessage.contains('network') ||
        lowerCaseMessage.contains('internet') ||
        lowerCaseMessage.contains('connection')) {
      return 'No internet connection. Please check and try again.';
    }

    if (lowerCaseMessage.contains('otp')) {
      return 'Please enter a valid OTP and try again.';
    }

    if (lowerCaseMessage.contains('phone')) {
      return 'Please check the phone number and try again.';
    }

    if (lowerCaseMessage.contains('user not logged in')) {
      return 'Your session has expired. Please login again.';
    }

    if (lowerCaseMessage.contains('user data not found')) {
      return 'Unable to get your profile details right now.';
    }

    if (lowerCaseMessage.contains('failed to send otp')) {
      return 'Unable to send OTP right now. Please try again.';
    }

    if (lowerCaseMessage.contains('verify')) {
      return 'Verification failed. Please try again.';
    }

    if (lowerCaseMessage.contains('save user') ||
        lowerCaseMessage.contains('save user data')) {
      return 'Unable to save your details right now. Please try again.';
    }

    if (lowerCaseMessage.contains('not available')) {
      return 'Required details are not available right now.';
    }

    return 'Something went wrong. Please try again.';
  }
}
