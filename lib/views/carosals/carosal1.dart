import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotpotproject/views/carosals/carosal3.dart';

class Carosal1 extends StatelessWidget {
  const Carosal1({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 22, 21, 21),
        body: SizedBox(
          height: size.height * 0.80,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.10),
                Center(
                  child: Container(
                    height: size.width * 0.50,
                    width: size.width * 0.50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("asset/image/food-2048x1366.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Explore",
                  style: GoogleFonts.bilboSwashCaps(
                    textStyle: const TextStyle(color: Colors.white),
                    fontSize: 80,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "find varieties of meals \n restaurant close to your\n location",
                  style: GoogleFonts.allan(
                    textStyle: const TextStyle(color: Colors.white),
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: size.height * 0.13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 20),
                    Row(children: [
                      Text("SWIPE",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      SizedBox(
                        width: 200,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Carosal3()));
                          },
                          child: Text(
                            "SKIP",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ))
                    ])
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
