import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotpotproject/controller/firebase/product_service/product_service.dart';
import 'package:hotpotproject/views/home/description.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    Repository().getProducs();
    super.initState();
  }

  String search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 7, 6, 2),
        appBar: AppBar(
          backgroundColor: Colors.red,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 173, 133, 241),
                  Color.fromARGB(255, 228, 13, 85)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                hintText: 'search',
                hintStyle: TextStyle(color: Colors.white),
                // border: OutlineInputBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(20))),
                border: InputBorder.none),
            onChanged: (value) {
              setState(() {
                search = value;
              });
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: ValueListenableBuilder(
              valueListenable: dishNotifier,
              builder: (context, dishList, _) {
                final list = dishList
                    .where((element) =>
                        element.dishCategory
                            .toLowerCase()
                            .contains(search.toLowerCase()) ||
                        element.dishName
                            .toLowerCase()
                            .contains(search.toLowerCase()))
                    .toList();
                if (list.isNotEmpty) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final dish = list[index];
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
                          height: 200,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromARGB(255, 177, 32, 80)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  height: 150,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(dish.dishImage),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                              //     Icon(Icons.update_disabled_rounded),
                              //   ],
                              // ),
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
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 60,
                    ),
                    itemCount: list.length,
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
