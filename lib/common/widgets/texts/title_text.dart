import 'package:flutter/material.dart';


class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget({
    super.key, required this.title, required this.subtitle,
  });
  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textTheme.titleMedium),
        Text(
          subtitle,
          style: textTheme.labelSmall,
        ),
      ],
    );
  }
}