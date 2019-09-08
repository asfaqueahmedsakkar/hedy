import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function onPress;
  final Color fillColor, textColor, borderColor;
  final bool enabled;

  const CustomButton(
      {Key key,
      this.title,
      this.onPress,
      this.fillColor,
      this.enabled = true,
      this.textColor,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54.0,
      child: RawMaterialButton(
        elevation: 0.0,
        highlightElevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        fillColor: fillColor,
        splashColor: Colors.white.withOpacity(0.75),
        padding: EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.1,
              color: borderColor ?? Colors.white,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              title,
              style:
                  TextStyle(color: textColor ?? Colors.white, fontSize: 18.0),
            ),
          ),
        ),
        onPressed: enabled ? onPress : null,
      ),
    );
  }
}
