import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final int fillColor;
  final int textColor;
  final double textSize;
  final Function callback;

  CalculatorButton({
    required this.text,
    this.fillColor = 0xFF2C3E50,  
    this.textColor = 0xFFFFFFFF,  
    this.textSize = 28,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: SizedBox(
        width: 70,
        height: 70,
        child: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(8, 8))
            ),
            backgroundColor: Color(fillColor),
            foregroundColor: Color(textColor),
          ),
          onPressed: () {
            callback(text);
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: textSize,
            ),
          ),
        ),
      ),
    );
  }
}
