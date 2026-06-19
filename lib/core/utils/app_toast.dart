import 'package:fluttertoast/fluttertoast.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';

class AppToast {
  AppToast._();

  static Future<void> show(String message) async {
    await Fluttertoast.cancel();
    await Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.authCard,
      textColor: AppColors.white,
      fontSize: AppTextStyles.authDisclaimer.fontSize,
    );
  }
}
