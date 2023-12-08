import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotpotproject/views/admin/home2.dart';
import 'package:hotpotproject/views/carosals/maincarosal.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.logOrNot});
  final bool logOrNot;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
              
                widget.logOrNot ? const Home2Screen() : const Maincarosal()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 5, 0, 0),
          body: Center(
              child: Text("HotPot",
                  style: GoogleFonts.allura(
                      textStyle: TextStyle(
                          color: Colors.yellow[600],
                          letterSpacing: .5,
                          fontSize: 50))))),
    );
  }
}
