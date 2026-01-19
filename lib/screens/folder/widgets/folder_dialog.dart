import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../theme/theme.dart';

// TODO: Colors should be like in Feeds

class FolderDialog extends StatelessWidget {
  final Function(BuildContext context) addFolderPressed;
  final Function() outsideDialogPressed;
  final TextEditingController folderTitleTextController;
  final TextEditingController folderDescriptionTextController;
  final String fontFamily;

  const FolderDialog({
    required this.addFolderPressed,
    required this.outsideDialogPressed,
    required this.folderTitleTextController,
    required this.folderDescriptionTextController,
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
                          NovinarkoIcons.addFolder,
                          fit: BoxFit.cover,
                          color: context.colors.text,
                          height: 36,
                          width: 36,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        // TODO
                        'Add folder',
                        style: context.textStyles.newsFeedInfoTitle,
                        textAlign: TextAlign.center,
                      ),
                      FolderDialogTextField(
                        textController: folderTitleTextController,
                        // TODO
                        labelText: 'Folder title',
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        autocorrect: true,
                        fontFamily: fontFamily,
                      ),
                      FolderDialogTextField(
                        textController: folderDescriptionTextController,
                        // TODO
                        labelText: 'Folder description',
                        keyboardType: TextInputType.text,
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
                            color: context.colors.text,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          // TODO
                          'Add folder'.toUpperCase(),
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

class FolderDialogTextField extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool autocorrect;
  final String fontFamily;

  const FolderDialogTextField({
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
            style: context.textStyles.searchTextField.copyWith(
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
        fontFamily: fontFamily,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
