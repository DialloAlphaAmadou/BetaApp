import 'package:flutter/material.dart';

class ButtonWidget {

  //Button
  static Widget button({required VoidCallback onPressed, required bool isLoading, required String text, IconData? icon, }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 22, height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              )
            :  Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon),
                  const SizedBox(width: 8),
                ],
                Text(text),
              ],
            ),
      ),
    );
  }

  

  
  
}
  