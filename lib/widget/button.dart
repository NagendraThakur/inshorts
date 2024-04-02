import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String buttonText;
  final double? radius;
  final VoidCallback onPressed;
  final double? horizontalPadding;
  final double? verticalPadding;
  final bool? secondaryButton;
  final Widget? child;
  final bool? enable;

  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.width,
    this.height,
    this.radius,
    this.horizontalPadding,
    this.verticalPadding,
    this.secondaryButton,
    this.child,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 20, horizontal: horizontalPadding ?? 0),
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 50,
        decoration: BoxDecoration(
          color: enable!
              ? secondaryButton == true
                  ? Colors.white
                  : Theme.of(context).primaryColor
              : Colors.blueGrey,

          borderRadius: BorderRadius.circular(radius ?? 5.0),
          border: secondaryButton == true ? Border.all() : null,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 1,
          //     blurRadius: 5,
          //     offset: const Offset(2, 1),
          //   ),
          // ],
        ),
        child: InkWell(
          onTap: enable! ? onPressed : null,
          child: child ??
              TextButton(
                onPressed: null,
                child: Text(
                  buttonText,
                  style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                      color: secondaryButton == true
                          ? Colors.black
                          : Colors.white),
                ),
              ),
        ),
      ),
    );
  }
}
