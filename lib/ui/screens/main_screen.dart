import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: const Text(
        'The Spot!',
        style: TextStyle(
          color: Colors.white,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
