import 'package:flutter/material.dart';
import '../../util/extentions/extensions.dart';

class TextFieldHeader extends StatelessWidget {
  final String title;
  const TextFieldHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Column(
      children: [
        Text.rich(TextSpan(children: [
          TextSpan(text: title, style: textTheme.labelLarge),
          TextSpan(text: ' *', style: textTheme.labelLarge)
        ])),
        const SizedBox(
          height: 7,
        ),
      ],
    );
  }
}
