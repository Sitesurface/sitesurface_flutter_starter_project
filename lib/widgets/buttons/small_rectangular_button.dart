import 'package:flutter/material.dart';

class SmallRectangleButton extends StatelessWidget {
  const SmallRectangleButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color,
    this.textColor,
  }) : super(key: key);
  final String label;
  final Function onPressed;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: color ?? Colors.grey[400],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: textColor ?? Colors.black),
        ),
      ),
    );
  }
}
