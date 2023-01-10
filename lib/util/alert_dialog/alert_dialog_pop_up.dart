// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AlertDialogPopUp extends StatelessWidget {
  const AlertDialogPopUp({
    required this.onPressed,
    required this.title,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No')),
        TextButton(onPressed: onPressed, child: const Text('Yes')),
      ],
    );
  }
}
