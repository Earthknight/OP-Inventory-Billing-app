import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? ontap;

  const MyListTile({
    required this.title,
    this.subtitle,
    this.trailing,
    this.leading,
    this.ontap
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      onTap: ontap,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
    );
  }
}



