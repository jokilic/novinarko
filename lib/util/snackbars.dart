import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../theme/theme.dart';

void showRemoveSomeFeedsSnackbar(BuildContext context, {required Function() onPressed}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'newsRemoveSnackbarText'.tr(),
        style: context.textStyles.snackbar.copyWith(
          color: context.colors.text,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      backgroundColor: context.colors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: context.colors.text,
          width: 1.5,
        ),
      ),
      action: SnackBarAction(
        label: 'newsRemoveSnackbarButton'.tr().toUpperCase(),
        textColor: context.colors.text,
        onPressed: onPressed,
      ),
    ),
  );
}

void showWebSnackbar(BuildContext context, {required String text}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: context.textStyles.snackbar.copyWith(
          color: context.colors.text,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      backgroundColor: context.colors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: context.colors.text,
          width: 1.5,
        ),
      ),
    ),
  );
}
