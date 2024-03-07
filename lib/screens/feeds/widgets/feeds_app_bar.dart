import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watch_it/watch_it.dart';

import '../../../constants.dart';
import '../../../services/theme_service.dart';
import '../../../theme/theme.dart';

class FeedsAppBar extends WatchingWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = watchIt<ThemeService>().value == NovinarkoTheme.dark;

    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: isDark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
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
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FeedsAppBarBack(
                onPressed: Navigator.of(context).pop,
              ),
              const Spacer(),
              FeedsAppBarTextIcon(
                onPressed: () {},
              ),
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
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 32);
}

class FeedsAppBarBack extends StatelessWidget {
  final Function() onPressed;

  const FeedsAppBarBack({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          highlightColor: context.colors.primary.withOpacity(0.6),
          fixedSize: const Size(48, 48),
          shape: const CircleBorder(),
          side: BorderSide(
            color: context.colors.background,
          ),
        ),
        icon: Center(
          child: Image.asset(
            NovinarkoIcons.back,
            fit: BoxFit.cover,
            color: context.colors.background,
            height: 20,
            width: 20,
          ),
        ),
      );
}

class FeedsAppBarTextIcon extends StatelessWidget {
  final Function() onPressed;

  const FeedsAppBarTextIcon({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Text(
            'appName'.tr(),
            style: context.textStyles.feedsNovinarko,
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: onPressed,
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              highlightColor: context.colors.primary.withOpacity(0.6),
              fixedSize: const Size(48, 48),
              shape: const CircleBorder(),
              side: BorderSide(
                color: context.colors.background,
              ),
            ),
            icon: Center(
              child: ClipOval(
                child: Image.asset(
                  NovinarkoIcons.icon,
                  fit: BoxFit.cover,
                  height: 48,
                  width: 48,
                ),
              ),
            ),
          ),
        ],
      );
}
