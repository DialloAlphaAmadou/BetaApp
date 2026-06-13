import 'package:flutter/material.dart';

class ButtonWidget {

  //Button
  static Widget button({required VoidCallback? onPressed, required bool isLoading, required String text, IconData? icon, }) {
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

  static Widget navigationButton({ required BuildContext context, required String text, Widget? page, IconData? icon,}) {
    return TextButton(
      onPressed: () {
        if(page != null ){
          Navigator.push( context, MaterialPageRoute( builder: (_) => page, ), );
        }else {
          Navigator.pop(context); // retour 
        }
      },
      child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18),
          const SizedBox(width: 6),
        ],
        Text(text),
      ],
    ),
    );
  }


  
  
}
  