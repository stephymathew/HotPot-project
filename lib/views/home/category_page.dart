import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hotpotproject/controller/firebase/product_service/product_service.dart';

import 'package:hotpotproject/views/home/description.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.tabLabel});
  final String tabLabel;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 3, 7, 4),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 122, 6, 22),
          
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: FutureBuilder(
              future: Repository()
                  .getProducsByCategory(category: tabLabel.toLowerCase()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final dish = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DescriptionPage(dish: dish),
                            ),
                          );
                        },
                        child: Container(
                          height: screenSize.height*.2,
                          width: screenSize.width*3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromARGB(255, 122, 6, 22)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  height: screenSize.height*2,
                                  width: screenSize.height*0.12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(dish.dishImage),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      dish.dishName,
                                      style: GoogleFonts.aboreto(
                                        textStyle: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      dish.dishPrice,
                                      style: GoogleFonts.aboreto(
                                          textStyle:
                                              const TextStyle(fontSize: 15),
                                          color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: RatingBar.builder(
                                          initialRating: 3,
                                          minRating: 1,
                                          direction: Axis.vertical,
                                          allowHalfRating: true,
                                          itemCount: 4,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 1.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Color.fromARGB(
                                                255, 232, 233, 228),
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>  SizedBox(
                      height: screenSize.height*0.06,
                    ),
                    itemCount: snapshot.data!.length,
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ));
  }
}
