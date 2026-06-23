import 'package:flutter/material.dart';

class ToolsWidget {

  
  static Future<void> showInfoDialog( BuildContext context, String message, ) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.blue,
              size: 30,
            ),
            SizedBox(width: 10),
            Text("Information"),
          ],
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(dialogContext),
            icon: const Icon(Icons.check),
            label: const Text("OK"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              minimumSize: const Size(120, 45),
            ),
          ),
        ],
      ),
    );
  }

  static Future<bool?> showConfirmDialog(BuildContext context, String message,) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: const [
            Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange,
              size: 30,
            ),
            SizedBox(width: 10),
            Text("Confirmation requise"),
          ],
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          OutlinedButton.icon(
            onPressed: () => Navigator.pop(dialogContext, false),
            icon: const Icon(Icons.close),
            label: const Text("Annuler"),
          ),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(dialogContext, true),
            icon: const Icon(Icons.check),
            label: const Text("Continuer"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
  
}