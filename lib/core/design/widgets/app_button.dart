import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final bool isLoading;
  final String text;
  final void Function()? onPressed;
  final bool isPrimaryColor;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isPrimaryColor = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 200,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          backgroundColor: isPrimaryColor
              ? Theme.of(context).colorScheme.primary
              : Colors.black,
        ),
        child: isLoading
            ? const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              )
            : Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
      ),
    );
  }
}
