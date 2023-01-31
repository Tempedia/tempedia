import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String text;

  const DividerWithText({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      SizedBox(
        width: 60,
        child: Divider(
          height: 40,
          color: Colors.grey.shade300,
          thickness: 1,
        ),
      ),
      Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      Expanded(
        flex: 3,
        child: Divider(
          height: 40,
          color: Colors.grey.shade300,
          thickness: 1,
        ),
      ),
    ]);
  }
}
