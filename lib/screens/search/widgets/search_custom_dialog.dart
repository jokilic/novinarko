import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../theme/theme.dart';

class SearchCustomDialog extends StatelessWidget {
  final Function(BuildContext context) addFeedPressed;
  final Function() outsideDialogPressed;
  final TextEditingController feedTitleTextController;
  final TextEditingController feedUrlTextController;
  final TextEditingController siteNameTextController;

  const SearchCustomDialog({
    required this.addFeedPressed,
    required this.outsideDialogPressed,
    required this.feedTitleTextController,
    required this.feedUrlTextController,
    required this.siteNameTextController,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: outsideDialogPressed,
        child: ScaffoldMessenger(
          child: Builder(
            builder: (context) => Scaffold(
              backgroundColor: Colors.transparent,
              body: GestureDetector(
                onTap: () {},
                child: Dialog(
                  backgroundColor: context.colors.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: context.colors.text,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 28,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: context.colors.text,
                                width: 2,
                              ),
                            ),
                            child: Image.asset(
                              NovinarkoIcons.customSearch,
                              fit: BoxFit.cover,
                              color: context.colors.text,
                              height: 36,
                              width: 36,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'searchCustomFeedDialogTitle'.tr(),
                            style: context.textStyles.newsFeedInfoTitle,
                            textAlign: TextAlign.center,
                          ),
                          SearchCustomDialogTextField(
                            textController: feedTitleTextController,
                            labelText: 'searchCustomFeedTitle'.tr(),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            autocorrect: true,
                          ),
                          SearchCustomDialogTextField(
                            textController: feedUrlTextController,
                            labelText: 'searchCustomFeedUrl'.tr(),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.next,
                            autocorrect: false,
                          ),
                          SearchCustomDialogTextField(
                            textController: siteNameTextController,
                            labelText: 'searchCustomSiteName'.tr(),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.done,
                            autocorrect: true,
                          ),
                          const SizedBox(height: 28),
                          TextButton(
                            onPressed: () => addFeedPressed(context),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              elevation: 0,
                              side: BorderSide(
                                color: context.colors.text,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              'searchCustomAddFeed'.tr().toUpperCase(),
                              style: context.textStyles.searchCustomDialogButton,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class SearchCustomDialogTextField extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool autocorrect;

  const SearchCustomDialogTextField({
    required this.textController,
    required this.labelText,
    required this.keyboardType,
    required this.textInputAction,
    required this.autocorrect,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 2,
        ),
        child: TextField(
          autocorrect: autocorrect,
          enableSuggestions: autocorrect,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          controller: textController,
          cursorColor: context.colors.text,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.colors.text,
                width: 2,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.colors.text,
                width: 2,
              ),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.colors.text,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            label: Center(
              child: Text(
                labelText,
                style: context.textStyles.searchTextField,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            alignLabelWithHint: true,
          ),
          style: context.textStyles.searchTextField,
          textAlign: TextAlign.center,
        ),
      );
}
