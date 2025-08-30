import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../theme/theme.dart';

class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) => AppBar(
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(16),
      ),
    ),
    bottom: PreferredSize(
      preferredSize: Size.infinite,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SettingsAppBarBack(
              onPressed: Navigator.of(context).pop,
            ),
            SettingsTitle(
              title: 'settingsTitle'.tr(),
            ),
            const SizedBox(width: 48),
          ],
        ),
      ),
    ),
    flexibleSpace: ClipRRect(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(16),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 16,
          sigmaY: 16,
        ),
        child: Container(
          color: Colors.transparent,
        ),
      ),
    ),
  );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 32);
}

class SettingsAppBarBack extends StatelessWidget {
  final Function() onPressed;

  const SettingsAppBarBack({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onPressed,
    style: IconButton.styleFrom(
      highlightColor: context.colors.primary.withValues(alpha: 0.6),
      fixedSize: const Size(50, 50),
      shape: const CircleBorder(),
      side: BorderSide(
        color: context.colors.text,
        width: 2,
      ),
    ),
    icon: Center(
      child: Image.asset(
        NovinarkoIcons.back,
        fit: BoxFit.cover,
        color: context.colors.text,
        height: 20,
        width: 20,
      ),
    ),
  );
}

class SettingsTitle extends StatelessWidget {
  final String title;

  const SettingsTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) => Text(
    title,
    style: context.textStyles.appBarTitle,
  );
}
