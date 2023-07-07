import 'package:flutter/material.dart';
import 'package:solbombas/constant/color.dart';
import 'package:solbombas/constant/strings.dart';
import 'package:solbombas/constant/style.dart';

class CustomTextFieldSearch extends StatelessWidget {
  final String? initialValue;
  final TextEditingController? textController;
  final bool enable;

  const CustomTextFieldSearch(
      {Key? key,
        this.textController,
        this.enable = true, this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      //initialValue: initialValue,
      decoration: InputDecoration(prefixIcon: Icon(Icons.search, color: ColorPalette.primary),
        border: OutlineInputBorder(
          borderSide:
          BorderSide(color: Theme.of(context).colorScheme.onBackground),
          borderRadius: BorderRadius.circular(8),
        ),
        fillColor: Theme.of(context).primaryColorDark,
        hintText: null == initialValue ? Strings.defaultHintLabel : initialValue!,
        hintStyle: Styles.textRegular,
      ),
      controller: textController,
    );
  }
}