import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.cloud),
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
