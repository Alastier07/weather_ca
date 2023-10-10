import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    this.refreshFunction,
    this.message,
    this.btnMessage,
  });

  final VoidCallback? refreshFunction;
  final String? message;
  final String? btnMessage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error),
          const SizedBox(height: 20),
          Text(message ?? 'Please check your internet connection.'),
          if (refreshFunction != null)
            TextButton(
              onPressed: refreshFunction,
              child: Text(btnMessage ?? 'Try Again'),
            ),
        ],
      ),
    );
  }
}
