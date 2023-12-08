// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotpotproject/views/admin/login.dart';
import 'package:hotpotproject/views/admin/signUp.dart';


class LoginhomeScreen extends StatelessWidget {
  const LoginhomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 180,
                  width: 180,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("asset/image/food-2048x1366.jpg"),
                          fit: BoxFit.cover),
                          
                      shape: BoxShape.circle),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 80,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("asset/image/food-2048x1366.jpg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100),
                            bottomRight: Radius.circular(100))),
                  ),
                  const Spacer(),
                  Text(
                    "HotPot",
                    style: GoogleFonts.irishGrover(
                        fontSize: 55, color: Colors.yellow),
                  ),
                  const Spacer(),
                  Container(
                    height: 150,
                    width: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("asset/image/food-2048x1366.jpg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                            topLeft: Radius.circular(100))),
                  ),
                ],
              ),
              Container(
                height: 180,
                width: 180,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("asset/image/food-2048x1366.jpg"),
                        fit: BoxFit.cover),
                    shape: BoxShape.circle),
              ),
              const SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.amber,
                  ),
                  child: Center(
                      child: Text(
                    "Login",
                    style: GoogleFonts.alice(
                        fontSize: 35, fontWeight: FontWeight.normal),
                  )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
                },
                child: Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.amber,
                  ),
                  child: Center(
                      child: Text(
                    "Create Account",
                    style: GoogleFonts.alice(
                        fontSize: 35, fontWeight: FontWeight.normal),
                  )),
                ),
              ),
            ],
          )),
    );
  }
}
