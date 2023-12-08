import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotpotproject/controller/firebase/product_service/product_service.dart';
import 'package:hotpotproject/model/food_models.dart';
import 'package:hotpotproject/views/home/description.dart';
import 'package:hotpotproject/views/home/list_screen.dart';

import 'package:hotpotproject/views/home/category_page.dart';
import 'package:hotpotproject/views/home/orders.dart';
import 'package:hotpotproject/views/home/search_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });

  int currentIndex = 0;
  int index = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
      final Size screenSize = MediaQuery.of(context).size;
    List<String> img = [
      "asset/image/HOT BEVARAGE.png",
      "asset/image/JUICES.jpg",
      "asset/image/MOJITO.jpg",
      "asset/image/SHAKES.jpg",
      "asset/image/JUICES.jpg",
      "asset/image/MOJITO.jpg",
      "asset/image/SHAKES.jpg",
    ];

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 231, 101, 78),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ListScreen(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 7, 6, 6),
              ),
              child: Center(
                child: Text(
                  'HotPot',
                  style: TextStyle(
                    color: Color.fromARGB(255, 233, 222, 222),
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            // ListTile(
            //   title: const Text('Review'),
            //   onTap: () {
            //     _showReviewDialog(context);
            //   },
            // ),
            ListTile(
              title: const Text('Orders'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 7, 1, 4),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.irishGrover(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                  children: const [
                    TextSpan(text: "Find Your \n Own "),
                    TextSpan(
                      text: "Food",
                      style: TextStyle(
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchScreen()));
                },
                child: Container(
                  height: screenSize.height*.06,
                  width: screenSize.width*.80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: const Color.fromARGB(255, 102, 98, 98),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      "Search",
                      style: GoogleFonts.notoSansOldItalic(
                        textStyle: const TextStyle(color: Colors.white),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Spacer(),
                  buildTabContainer("All", 0, context),
                  const Spacer(),
                  buildTabContainer("Burger", 1, context),
                  const Spacer(),
                  buildTabContainer("Pizza", 2, context),
                  const Spacer(),
                  buildTabContainer("Sandwich", 3, context),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: screenSize.height*.05,
                    width: screenSize.width*.35,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 119, 111, 111),
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0.1, 0.5],
                        colors: [
                          Color.fromARGB(255, 243, 196, 9),
                          Colors.red,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Drinks",
                        style: GoogleFonts.abyssinicaSil(
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: screenSize.height*.13,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: img.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryScreen(
                                tabLabel: getCategoryName(index)),
                          ),
                        );
                        // print("Circle tapped at index $index");
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        width: screenSize.height*0.08,
                        height: screenSize.height*0.08,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(img[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Popular",
                    style: GoogleFonts.athiti(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              FutureBuilder<List<Dishes>>(
                future: Repository().getPopularCategory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var dishes = snapshot.data;
                    return SizedBox(
                      height: screenSize.height*.31,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dishes!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DescriptionPage(dish: dishes[index]),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  width: screenSize.height*0.15,
                                  height: screenSize.height*0.22,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(40),
                                    image: DecorationImage(
                                      image: dishes[index].dishImage.isNotEmpty
                                          ? Image.network(
                                                  dishes[index].dishImage)
                                              .image
                                          : Image.asset(
                                                  'asset/image/close-up-burger-with-black-background_23-2148234990.webp')
                                              .image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                dishes[index].dishName,
                                style: GoogleFonts.abel(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabContainer(String label, int index, BuildContext context) {
    bool isSelected = currentIndex == index;

    void navigateToScreen(String tabLabel) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryScreen(
            tabLabel: label,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        if (label == "Burger" ||
            label == "Sandwich" ||
            label == "Pizza" ||
            label == "Tea" ||
            label == "Juices" ||
            label == "Mojitos" ||
            label == "Shakes" ||
            label == "Cooldrinks" ||
            label == 'Popular=true') {
          navigateToScreen(label);
        }
      },
      child: Container(
        height: 40,
        width: 90,
        decoration: BoxDecoration(
          color: isSelected ? Colors.yellow : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.irishGrover(
              textStyle: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  void _showReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String reviewText = '';

        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  reviewText = value;
                },
                decoration: const InputDecoration(labelText: 'Your Review'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                print('Review submitted: $reviewText');
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

String getCategoryName(int index) {
  switch (index) {
    case 0:
      return "tea";
    case 1:
      return "juices";
    case 2:
      return "mojitos";
    case 3:
      return "shakes";
    case 4:
      return "cooldrinks";
    default:
      return "";
  }
}
