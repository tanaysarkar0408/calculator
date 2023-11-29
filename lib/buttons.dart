import 'package:flutter/material.dart';

// creating Stateless Widget for buttons
class MyButton extends StatelessWidget {

// declaring variables
  final color;
  final textColor;
  final String buttonText;
  final buttontapped;

//Constructor
  MyButton({this.color, this.textColor, required this.buttonText, this.buttontapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(0.2),
        // child: ClipRRect(
        //   borderRadius: BorderRadius.circular(50),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 40,
                  spreadRadius: 5,
                  offset: Offset(4,4),
                )
              ],
              color: color,
            ),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
    );
  }
}
