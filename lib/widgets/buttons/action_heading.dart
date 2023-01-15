import 'package:flutter/material.dart';

class ActionHeading extends StatelessWidget {
  const ActionHeading({
    Key? key,
    required this.heading,
    this.onPressed,
    required this.totalItemsCount,
    this.showViewAll = false,
  }) : super(key: key);

  final String heading;
  final VoidCallback? onPressed;
  final int totalItemsCount;
  final bool showViewAll;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Text(
              heading,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        showViewAll
            ? TextButton(
                onPressed: onPressed,
                child: Text("View All ($totalItemsCount)"))
            : const SizedBox()
      ],
    );
  }
}
