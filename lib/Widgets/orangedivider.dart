import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class RedDivider extends StatelessWidget {
  const RedDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40.0,
      ),
      child: Divider(
        color: HexColor('C9EEFF'),
        thickness: 1,
      ),
    );
  }
}
