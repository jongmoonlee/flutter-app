import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {this.buttonTitle, this.buttonColour, @required this.onPressed});
  final Color buttonColour;
  final String buttonTitle;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        elevation: 5.0,
        color: buttonColour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            buttonTitle,
          ),
        ),
      ),
    );
  }
}

class IconBtn extends StatelessWidget {
  IconBtn({this.iconColor, this.bgColor, this.icon, this.size, this.onPressed});
  final Color iconColor;
  final Color bgColor;
  final Icon icon;
  final Function onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Ink(
          decoration: ShapeDecoration(
            color: bgColor,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: icon,
            color: iconColor,
            iconSize: size,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}