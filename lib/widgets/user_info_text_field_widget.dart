import 'package:flutter/material.dart';

class UserInfoTextFieldWidget<T> extends StatelessWidget {
  UserInfoTextFieldWidget({
    Key? key,
    this.initialText,
    required this.textHint,
    required this.onChangedText,
  }) : super(key: key);
  final T? initialText;
  final String textHint;

  final ValueChanged<String> onChangedText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextFormField(
        initialValue: initialText?.toString() ?? '',
        onChanged: ((value) => onChangedText(value)),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          isDense: true,
          hintText: '${textHint}',
          hintStyle: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 1.0,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2.0,
              style: BorderStyle.solid,
            ),
          ),
        ),
        enabled: true,
      ),
    );
  }
}
