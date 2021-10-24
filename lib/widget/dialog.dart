import 'package:flutter/material.dart';

typedef void OnPositiveCallback();
typedef void OnNegativeCallback();

class IconDialog extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget content;
  final Color color;
  final String textPositive;
  final String textNegative;
  final OnPositiveCallback onPositive;
  final OnNegativeCallback onNegative;

  IconDialog({
    required this.icon,
    required this.title,
    this.textPositive = 'Agree',
    this.textNegative = 'Cancel',
    required this.color,
    required this.content,
    required this.onPositive,
    required this.onNegative,
  });

  @override
  Widget build(BuildContext context) {

    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: IntrinsicWidth(
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: -29.0,
              child: Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 28.0,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 42.0,
                    left: 16.0,
                    right: 16.0,
                    bottom: 16.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.title!.copyWith(
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      DefaultTextStyle(
                        child: content,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                onNegative != null
                    ? Container(
                  alignment: Alignment.center,
                  height: 42.0,
                  margin: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Text(
                      textNegative,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: onNegative,
                  ),
                )
                    : SizedBox(),
                Container(
                  height: 48.0,
                  child: FlatButton(
                    textColor: Colors.white,
                    color: color,
                    splashColor: Colors.transparent,
                    child: Text(
                      textPositive,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(2.0),
                        bottomRight: Radius.circular(2.0),
                      ),
                    ),
                    onPressed: onPositive,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
