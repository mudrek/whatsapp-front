import 'package:flutter/material.dart';
import 'package:kydrem_whatsapp/core/design/widgets/app_button.dart';

// ignore: must_be_immutable
class AppChoiceDialog extends StatelessWidget {
  final Color? titleColor;
  final Color? messageColor;
  final Color? buttonOkColor;
  final Color? buttonCancelBorderColor;
  final String title;
  final String message;
  final String buttonOkText;
  final String buttonCancelText;
  final VoidCallback? buttonOkOnPressed;
  final VoidCallback? buttonCancelOnPressed;
  final double dialogRadius;
  final double buttonRadius;
  final Icon? iconButtonOk;
  final Icon? iconButtonCancel;

  AppChoiceDialog({
    Key? key,
    this.buttonOkColor,
    this.buttonCancelBorderColor,
    this.title = 'Dialog Title',
    this.titleColor,
    this.message = 'Dialog Message',
    this.messageColor,
    this.buttonOkText = 'Ok',
    this.buttonCancelText = 'Cancel',
    this.buttonOkOnPressed,
    this.buttonCancelOnPressed,
    this.dialogRadius = 15.0,
    this.buttonRadius = 18.0,
    this.iconButtonOk,
    this.iconButtonCancel,
  }) : super(key: key);

  AppChoiceDialog? _choiceDialog;

  bool _isShowing = false;

  void dismiss(BuildContext? context) {
    if (_isShowing) {
      _isShowing = false;
      Navigator.pop(context!);
    }
  }

  void _initializeProgress() {
    _choiceDialog = AppChoiceDialog(
      buttonOkColor: buttonOkColor,
      title: title,
      titleColor: titleColor,
      message: message,
      messageColor: messageColor,
      buttonOkText: buttonOkText,
      buttonCancelText: buttonCancelText,
      buttonOkOnPressed: buttonOkOnPressed,
      buttonCancelOnPressed: buttonCancelOnPressed,
      dialogRadius: dialogRadius,
      buttonRadius: buttonRadius,
      iconButtonOk: iconButtonOk,
      iconButtonCancel: iconButtonCancel,
      buttonCancelBorderColor: buttonCancelBorderColor,
    );
  }

  void show(BuildContext? context,
      {Color? barrierColor = Colors.black54,
      bool? barrierDismissible = true}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!_isShowing) {
      _isShowing = true;
      if (_choiceDialog == null) _initializeProgress();
      await showDialog(
        context: context!,
        useSafeArea: true,
        barrierDismissible: barrierDismissible!,
        builder: (context) => _choiceDialog!,
        barrierColor: barrierColor!.withOpacity(.2),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(dialogRadius)),
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(dialogRadius),
          color: Theme.of(context).colorScheme.background,
        ),
        padding: const EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width * .7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, left: 3.0, right: 3.0, bottom: 4.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 12.0, bottom: 16.0, right: 3.0, left: 3.0),
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 3.0, right: 3.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 5,
                    child: TextButton(
                      child: Text(
                        buttonCancelText,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      onPressed: () {
                        buttonCancelOnPressed?.call();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 5,
                    child: AppButton(
                      text: buttonOkText,
                      onPressed: () {
                        buttonOkOnPressed?.call();
                        Navigator.pop(context);
                      },
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
}
