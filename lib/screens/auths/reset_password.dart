import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Reset Password"),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // retour login
              },
              child: const Text("Envoyer email"),
            ),
          ],
        ),
      ),
    );
  }
}