import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotpotproject/views/admin/LoginScreen.dart';
import 'package:hotpotproject/views/home/home.dart';


class Carosal3 extends StatelessWidget {
  const Carosal3({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 22, 21, 21),
        body: 
        SizedBox(
          height: size.height* 0.90,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginhomeScreen()),
                    );
                  },
                  child: const Icon(Icons.person_3_sharp, color: Colors.white, size: 20),
                ),
              ),
                 SizedBox(height: size.height*0.08),
                Center(
                  child: Container(
                    height: size.width*0.50,
                    width: size.width*0.50,
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
                  "Enjoy!",
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
                 SizedBox(height: size.height*0.10), 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20),
                   
                        GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 160,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 221, 182, 9),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: const Center(
                        child: Text(
                          "Get Started",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                  )
                        
          
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