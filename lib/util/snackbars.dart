import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../theme/theme.dart';

void showRemoveSomeFeedsSnackbar(BuildContext context, {required Function() onPressed}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'newsRemoveSnackbarText'.tr(),
        style: context.textStyles.snackbar,
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: context.colors.text,
          width: 2,
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
