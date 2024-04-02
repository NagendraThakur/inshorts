import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final double? radius;
  final Color? color;
  final bool? border;
  final double? outerHorizontalPadding;
  final double? outerVerticalPadding;
  final double? innerHorizontalPadding;
  final double? innerVerticalPadding;
  final bool? rightBorder;
  final bool? leftBorder;

  const CustomContainer(
      {Key? key,
      this.width,
      this.height,
      this.child,
      this.radius,
      this.color,
      this.border,
      this.outerHorizontalPadding,
      this.outerVerticalPadding,
      this.innerHorizontalPadding,
      this.innerVerticalPadding,
      this.rightBorder,
      this.leftBorder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: outerHorizontalPadding ?? 0,
          vertical: outerVerticalPadding ?? 0),
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(
            horizontal: innerHorizontalPadding ?? 0,
            vertical: innerVerticalPadding ?? 0),
        decoration: rightBorder == true
            ? BoxDecoration(
                color: Theme.of(context).canvasColor,
                border: const Border(
                  right: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
              )
            : leftBorder == true
                ? BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    border: const Border(
                      left: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  )
                : BoxDecoration(
                    color: color ?? Colors.white,
                    borderRadius: BorderRadius.circular(radius ?? 2),
                    border:
                        border == true ? Border.all(color: Colors.grey) : null,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 1,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
        child: child,
      ),
    );
  }
}
