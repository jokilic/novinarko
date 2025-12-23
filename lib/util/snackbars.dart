import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../theme/theme.dart';

void showRemoveSomeFeedsSnackbar(
  BuildContext context, {
  required Function() onPressed,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      content: Row(
        children: [
          const SizedBox(width: 4),
          Image.asset(
            NovinarkoIcons.noNews,
            fit: BoxFit.cover,
            color: context.colors.text,
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'newsRemoveSnackbarText'.tr(),
              style: context.textStyles.snackbar.copyWith(
                color: context.colors.text,
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: context.colors.text,
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: onPressed,
            child: Text(
              'newsRemoveSnackbarButton'.tr().toUpperCase(),
              style: context.textStyles.snackbar.copyWith(
                color: context.colors.text,
              ),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: context.colors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: context.colors.text,
          width: 2,
        ),
      ),
    ),
  );
}

void showRestoreReadingSnackbar(
  BuildContext context, {
  required Function() onPressed,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      content: Row(
        children: [
          const SizedBox(width: 4),
          Image.asset(
            NovinarkoIcons.yesNews,
            fit: BoxFit.cover,
            color: context.colors.text,
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'newsRestoreReadingSnackbarText'.tr(),
              style: context.textStyles.snackbar.copyWith(
                color: context.colors.text,
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: context.colors.text,
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: onPressed,
            child: Text(
              'newsRestoreReadingSnackbarButton'.tr().toUpperCase(),
              style: context.textStyles.snackbar.copyWith(
                color: context.colors.text,
              ),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: context.colors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: context.colors.text,
          width: 2,
        ),
      ),
    ),
  );
}

void showSnackbar(
  BuildContext context, {
  required String text,
  required String icon,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      content: Row(
        children: [
          const SizedBox(width: 4),
          Image.asset(
            icon,
            fit: BoxFit.cover,
            color: context.colors.text,
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: context.textStyles.snackbar.copyWith(
                color: context.colors.text,
              ),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: context.colors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: context.colors.text,
          width: 2,
        ),
      ),
    ),
  );
}
