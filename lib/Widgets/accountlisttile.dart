import 'package:flutter/material.dart';

class AccountRepeatedListTile extends StatelessWidget {
  const AccountRepeatedListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.icon,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final Function() onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(
          icon,
        ),
      ),
    );
  }
}