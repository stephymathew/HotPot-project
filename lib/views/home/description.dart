import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotpotproject/controller/hive/product_hive.dart';
import 'package:hotpotproject/model/food_models.dart';

import 'package:hotpotproject/views/home/list_screen.dart';

class DescriptionPage extends StatelessWidget {
  const DescriptionPage({Key? key, required this.dish});
  final Dishes dish;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 235, 75, 64),
        title: Text(
          dish.dishName,
          style: GoogleFonts.amiri(
            textStyle:
                const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 1, 12, 12),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.60,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(dish.dishImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 20),
                  child: Text("₹${ dish.dishPrice}",
                   
                    style: const TextStyle(color: Colors.white, fontSize: 35),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              dish.dishName,
              style: GoogleFonts.abel(
                textStyle: const TextStyle(fontSize: 38, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                dish.dishDescription,
                style: GoogleFonts.inknutAntiqua(
                  textStyle: const TextStyle(
                    height: 2,
                    fontSize: 15,
                    color: Color.fromARGB(255, 240, 225, 225),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () async {
          try {
            await CartRepository.addToCart(dish).then((value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const ListScreen()),
                ));
          } catch (e) {
            e;
          }
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              "Add to List",
              style: GoogleFonts.alatsi(
                textStyle: const TextStyle(fontSize: 30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
