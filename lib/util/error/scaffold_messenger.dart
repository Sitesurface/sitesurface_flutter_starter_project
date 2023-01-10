import 'package:flutter/material.dart';

void scaffoldMessage({required BuildContext context, required String text}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
