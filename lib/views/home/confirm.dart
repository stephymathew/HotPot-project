import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotpotproject/views/home/home.dart';

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({super.key});
  @override
  Widget build(BuildContext context) {
      
    Color backgroundColor = const Color.fromARGB(255, 22, 43, 59);
    Timer(const Duration(milliseconds: 2500), () {
      
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    });

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          image: const DecorationImage(
            image: AssetImage(
                "asset/image/image_processing20201226-32597-12beljt.gif"),
          ),
        ),
      ),
    );
  }
}
