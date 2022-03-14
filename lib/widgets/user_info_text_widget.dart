import 'package:flutter/material.dart';

class UserInfoTextWidget extends StatelessWidget {
  const UserInfoTextWidget({
    Key? key,
    required this.title,
    this.text,
  }) : super(key: key);

  final String title;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            '$title',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (text != null) ...{
          Text(
            text!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        },
      ],
    );
  }
}
