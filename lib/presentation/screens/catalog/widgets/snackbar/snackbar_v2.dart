import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum SnackType {
  success,
  warning,
  error,
  info,
}

void showSnackBarV2({
  required BuildContext context,
  required String title,
  required String message,
  required SnackType snackType,
}) {
  const int textColor = 0xff000000;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      closeIconColor: const Color(textColor),
      showCloseIcon: true,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      backgroundColor: Color(getColorBySnackType(snackType)),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg_icons/${getIconBySnackType(snackType)}.svg",
            width: 24,
            height: 24,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextPoppins(
                  text: title,
                  fontSize: 13,
                  isBold: true,
                  textDark: textColor,
                  textLight: textColor,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextPoppins(
                    text: message,
                    fontSize: 12,
                    isBold: false,
                    textDark: textColor,
                    textLight: textColor,
                    lines: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

int getColorBySnackType(SnackType snackType) {
  switch (snackType) {
    case SnackType.success:
      return 0xff8FFF94;
    case SnackType.warning:
      return 0xffFFED66;
    case SnackType.error:
      return 0xffFFB6B2;
    case SnackType.info:
      return 0xffA2E6FA;
    default:
      return 0xffA2E6FA;
  }
}

String getIconBySnackType(SnackType snackType) {
  switch (snackType) {
    case SnackType.success:
      return "snack_success_icon";
    case SnackType.warning:
      return "snack_warning_icon";
    case SnackType.error:
      return "snack_error_icon";
    case SnackType.info:
      return "wifi_off_icon";
    default:
      return "wifi_off_icon";
  }
}