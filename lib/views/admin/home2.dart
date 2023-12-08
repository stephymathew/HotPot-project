import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotpotproject/controller/firebase/product_service/product_service.dart';
import 'package:hotpotproject/model/food_models.dart';
import 'package:hotpotproject/controller/firebase/auth/auth_service.dart';
import 'package:hotpotproject/views/admin/descriptionadmin.dart';
import 'package:hotpotproject/views/admin/foodadd.dart';
import 'package:hotpotproject/views/admin/orders_screen.dart';

class Home2Screen extends StatefulWidget {
  const Home2Screen({Key? key}) : super(key: key);

  @override
  _Home2ScreenState createState() => _Home2ScreenState();
}

class _Home2ScreenState extends State<Home2Screen> {
  int selectedTabIndex = 0;
  @override
  void initState() {
    Repository().getProducs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> img = [
      "asset/image/HOT BEVARAGE.png",
      "asset/image/JUICES.jpg",
      "asset/image/MOJITO.jpg",
      "asset/image/SHAKES.jpg",
      "asset/image/Screenshot 2023-11-16 102500.png",
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrdersAdminScreen(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 233, 40, 40),
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                  "HotPot",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Authservice.signOut(context);
              },
              child: const ListTile(
                title: Text(
                  "LogOut",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 12, 12, 12),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                ],
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
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildTabContainer("All", 0),
                  buildTabContainer("Burger", 1),
                  buildTabContainer("Pizza", 2),
                  buildTabContainer("Sandwich", 3),
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
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 119, 111, 111),
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [
                            0.1,
                            0.5,
                          ],
                          colors: [
                            Color.fromARGB(255, 230, 230, 14),
                            Color.fromARGB(255, 236, 42, 42)
                          ],
                        )),
                    child: Center(
                      child: Text(
                        "Drinks",
                        style: GoogleFonts.irishGrover(
                            textStyle: const TextStyle(fontSize: 20)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: img.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FoodAddScreen(
                                    tabLabel: getCategoryName(index))));
                        // print("Circle tapped at index $index");
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        width: 80,
                        height: 80,
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
                  child: Text("popular",
                      style: GoogleFonts.irishGrover(
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 40))),
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
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dishes!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DescriptionAdminPage(dish: dishes[index]),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  width: 120,
                                  height: 180,
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
                                Text(
                                  dishes[index].dishName,
                                  style: GoogleFonts.irishGrover(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
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

  Widget buildTabContainer(String label, int index) {
    bool isSelected = selectedTabIndex == index;

    void navigateToScreen(String tabLabel) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FoodAddScreen(tabLabel: tabLabel)),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTabIndex = index;
        });

        if (label == "Burger" ||
            label == "Sandwich" ||
            label == "Pizza" ||
            label == "tea" ||
            label == "juices" ||
            label == "mojitos" ||
            label == "shakes" ||
            label == "cooldrinks" ||
            label == 'popular=true') {
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
}
