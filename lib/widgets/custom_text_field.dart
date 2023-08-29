import 'package:flutter/material.dart';
import 'package:solbombas/constant/strings.dart';
import 'package:solbombas/constant/style.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final String? requiredLabel;
  final TextEditingController? textController;
  final bool enable;
  final TextInputType keyboardType;
  final VoidCallback? action;
  final FocusNode? focusNode;

   const CustomTextField(
      {Key? key,
        this.action,
        this.focusNode,
        required this.label,
        this.textController,
        this.requiredLabel,
        this.enable = true,
        this.initialValue,
        this.keyboardType = TextInputType.text,
        })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Styles.textRegular),
        const SizedBox(height: 8,),
        TextFormField(
          focusNode: focusNode,
          keyboardType: keyboardType,
          enabled: enable,
          //initialValue: initialValue,
          decoration: InputDecoration(
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
          validator: (value) => value!.isEmpty ? requiredLabel : null,
          onEditingComplete: action,
        ),
      ],
    );
  }
}