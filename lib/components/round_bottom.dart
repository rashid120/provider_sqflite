import 'package:flutter/material.dart';

class RoundBottom extends StatelessWidget {

  VoidCallback onPress;
  String text;
  Color bgColor;
  Color txColor;
  RoundBottom({super.key, required this.onPress, required this.text, required this.bgColor, required this.txColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      width: MediaQuery.of(context).size.width,
      child: MaterialButton(
        onPressed: onPress,
        splashColor: Colors.green.shade200,
        color: bgColor,
        child: Text(text, style: TextStyle(color: txColor),),
      ),
    );
  }
}
