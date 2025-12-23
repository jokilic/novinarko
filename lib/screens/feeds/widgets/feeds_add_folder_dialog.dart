import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../theme/theme.dart';

class FeedsAddFolderDialog extends StatelessWidget {
  final Function(BuildContext context) addFolderPressed;
  final Function() outsideDialogPressed;
  final TextEditingController folderNameTextController;
  final String fontFamily;

  const FeedsAddFolderDialog({
    required this.addFolderPressed,
    required this.outsideDialogPressed,
    required this.folderNameTextController,
    required this.fontFamily,
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
              backgroundColor: context.colors.text,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: context.colors.background,
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
                            color: context.colors.background,
                            width: 2,
                          ),
                        ),
                        child: Image.asset(
                          // TODO: Folder icon here
                          NovinarkoIcons.customSearch,
                          fit: BoxFit.cover,
                          color: context.colors.background,
                          height: 36,
                          width: 36,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        // TODO: Localize
                        'Add folder',
                        style: context.textStyles.newsFeedInfoTitle.copyWith(
                          color: context.colors.background,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      FeedsAddFolderDialogTextField(
                        textController: folderNameTextController,
                        // TODO: Localize
                        labelText: 'Folder title',
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        autocorrect: true,
                        fontFamily: fontFamily,
                      ),
                      const SizedBox(height: 28),
                      TextButton(
                        onPressed: () => addFolderPressed(context),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          elevation: 0,
                          side: BorderSide(
                            color: context.colors.background,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          // TODO: Localize
                          'Add folder'.toUpperCase(),
                          style: context.textStyles.searchCustomDialogButton.copyWith(
                            color: context.colors.background,
                          ),
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

class FeedsAddFolderDialogTextField extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool autocorrect;
  final String fontFamily;

  const FeedsAddFolderDialogTextField({
    required this.textController,
    required this.labelText,
    required this.keyboardType,
    required this.textInputAction,
    required this.autocorrect,
    required this.fontFamily,
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
      cursorColor: context.colors.background,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: context.colors.background,
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: context.colors.background,
            width: 2,
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: context.colors.background,
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
            style: context.textStyles.searchTextField.copyWith(
              color: context.colors.background,
              fontFamily: fontFamily,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        alignLabelWithHint: true,
      ),
      style: context.textStyles.searchTextField.copyWith(
        color: context.colors.background,
        fontFamily: fontFamily,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
