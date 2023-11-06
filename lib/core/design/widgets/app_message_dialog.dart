import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kydrem_whatsapp/core/design/widgets/app_button.dart';

// ignore: must_be_immutable
class AppMessageDialog extends StatelessWidget {
  final Color? dialogBackgroundColor;
  final Color? titleColor;
  final Color? messageColor;
  final Color? buttonOkColor;
  final String title;
  final String message;
  final String buttonOkText;
  final VoidCallback? buttonOkOnPressed;
  final double dialogRadius;
  final double buttonRadius;
  final Icon? iconButtonOk;

  AppMessageDialog({
    Key? key,
    this.dialogBackgroundColor = Colors.white,
    this.buttonOkColor,
    this.title = 'Dialog Title',
    this.titleColor,
    this.message = 'Dialog Message',
    this.messageColor,
    this.buttonOkText = 'Ok',
    this.buttonOkOnPressed,
    this.dialogRadius = 15.0,
    this.buttonRadius = 18.0,
    this.iconButtonOk,
  }) : super(key: key);

  bool _isShowing = false;

  AppMessageDialog? _messageDialog;

  void dismiss(BuildContext? context) {
    if (_isShowing) {
      _isShowing = false;
      Modular.to.pop();
    }
  }

  void _initializeProgress() {
    _messageDialog = AppMessageDialog(
        dialogBackgroundColor: dialogBackgroundColor,
        buttonOkColor: buttonOkColor,
        title: title,
        titleColor: titleColor,
        message: message,
        messageColor: messageColor,
        buttonOkText: buttonOkText,
        buttonOkOnPressed: buttonOkOnPressed,
        dialogRadius: dialogRadius,
        buttonRadius: buttonRadius,
        iconButtonOk: iconButtonOk);
  }

  void show(BuildContext? context,
      {Color? barrierColor = Colors.white,
      bool? barrierDismissible = true}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!_isShowing) {
      _isShowing = true;
      if (_messageDialog == null) _initializeProgress();
      await showDialog(
        context: context!,
        useSafeArea: true,
        barrierDismissible: barrierDismissible!,
        builder: (context) => _messageDialog!,
        barrierColor: barrierColor!.withOpacity(.5),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(dialogRadius),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(dialogRadius),
          color: Theme.of(context).colorScheme.background,
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 0.0,
                left: 3.0,
                right: 3.0,
                bottom: 4.0,
              ),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                bottom: 16.0,
                right: 3.0,
                left: 3.0,
              ),
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                left: 3.0,
                right: 3.0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: AppButton(
                    text: buttonOkText,
                    onPressed: () {
                      buttonOkOnPressed?.call();
                      Modular.to.pop();
                      // Navigator.pop(context);
                    },
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
