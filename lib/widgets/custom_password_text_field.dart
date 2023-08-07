import 'package:flutter/material.dart';
import 'package:solbombas/constant/style.dart';

class CustomPasswordTextField extends StatefulWidget {
  final String hintText;
  final String requiredLabel;
  final TextEditingController? textController;

  const CustomPasswordTextField(
      {Key? key, required this.hintText,required this.requiredLabel, this.textController})
      : super(key: key);

  @override
  State<CustomPasswordTextField> createState() => _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  late bool statePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      obscureText: statePassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide:
          BorderSide(color: Theme.of(context).colorScheme.onBackground),
          borderRadius: BorderRadius.circular(8),
        ),
        fillColor: Theme.of(context).primaryColorDark,
        hintText: widget.hintText,
        hintStyle: Styles.textRegular,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              statePassword = !statePassword;
            });
          },
          icon: Icon(
            statePassword ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      controller: widget.textController,
      validator: (value) => value!.isEmpty ? widget.requiredLabel : null,
    );
  }
}