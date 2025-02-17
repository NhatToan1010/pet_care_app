import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    this.onPressed,
  });

  final IconData leadingIcon;
  final String title, subtitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      onTap: onPressed,
      leading: Icon(leadingIcon),
      trailing: Icon(Icons.arrow_forward_ios_sharp),
      title: Text(
        title,
        style: textTheme.titleMedium,
      ),
      subtitle: Text(
        subtitle,
        style: textTheme.bodyMedium,
      ),
    );
  }
}
