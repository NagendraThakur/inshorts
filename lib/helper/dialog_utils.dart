import 'package:flutter/material.dart';

class DialogUtils {
  static void showProcessingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CircularProgressIndicator();
      },
    );
  }
}
