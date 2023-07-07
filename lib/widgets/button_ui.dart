import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solbombas/constant/color.dart';
import 'package:solbombas/constant/enums.dart';
import 'package:solbombas/constant/style.dart';
import 'package:solbombas/helpers/responsive_widget.dart';

class ButtonUI extends StatelessWidget {
  final String label;
  final IconData? icon;
  final ButtonType buttonType;
  final VoidCallback action;
  final bool forceExtended;
  final bool verticalLarge;

  const ButtonUI({
    Key? key,
    required this.label,
    this.icon,
    required this.action,
    this.buttonType = ButtonType.primary,
    this.forceExtended = false,
    this.verticalLarge = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (buttonType == ButtonType.primary) {
      return !ResponsiveWidget.isSmallScreen(context) || forceExtended
          ? ElevatedButton(
          onPressed: action,
          style: ElevatedButton.styleFrom(
              shadowColor: ColorPalette.blackGray,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18.0),
              elevation: 8),
          child: Padding(
            padding: verticalLarge ? const EdgeInsets.symmetric(vertical: 7) : const EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: Styles.textRegular
                      .copyWith(color: ColorPalette.white),
                ),
                const SizedBox(width: 4),
                Icon(icon,
                    size: 18, color: ColorPalette.white),
              ],
            ),
          ))
          : IconButton(
        icon: Icon(
          icon,
        ),
        iconSize: 24,
        color: Theme.of(context).primaryColor,
        splashColor: Theme.of(context).colorScheme.background,
        onPressed: action,
      );
    } else {
      return  OutlinedButton(
          onPressed: action,
          style: ButtonStyle(
            side: MaterialStateProperty.resolveWith<BorderSide?>(
                    (Set<MaterialState> states) {
                  return BorderSide(
                      color: buttonType == ButtonType.secondary
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.error,
                      width: 1); // Defer to the widget's default.
                }),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
                    (Set<MaterialState> states) {
                  return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ); // Defer to the widget's default.
                }),
            padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry?>(
                    (Set<MaterialState> states) {
                  return const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 18.0); // Defer to the widget's default.
                }),
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return buttonType == ButtonType.secondary
                        ? Theme.of(context).primaryColor.withOpacity(0.05)
                        : Theme.of(context).colorScheme.error.withOpacity(0.05);
                  }
                  if (states.contains(MaterialState.pressed)) {
                    return buttonType == ButtonType.secondary
                        ? Theme.of(context).primaryColor.withOpacity(0.25)
                        : Theme.of(context).colorScheme.error.withOpacity(0.25);
                  }
                  return buttonType == ButtonType.secondary
                      ? Theme.of(context).primaryColor
                      : Theme.of(context)
                      .colorScheme.error; // Defer to the widget's default.
                }),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text( label ,
                style: Styles.textRegular.copyWith(
                    color: buttonType == ButtonType.secondary
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.error),
              ),
              if (!ResponsiveWidget.isSmallScreen(context))
                const SizedBox(width: 4),
              icon.isNull?const SizedBox():Icon(icon,
                  size: 18,
                  color: buttonType == ButtonType.secondary
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).colorScheme.error),
            ],
          ));
    }
  }
}