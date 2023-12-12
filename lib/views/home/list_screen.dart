// ignore_for_file: unused_element

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hotpotproject/controller/hive/product_hive.dart';

import 'package:hotpotproject/views/home/home.dart';
import 'package:hotpotproject/views/home/table_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({
    Key? key,
  });

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  bool showAddPreferenceButton = false;
  bool userCancelled = false;
  bool userSaved = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.red,),
        backgroundColor: const Color.fromARGB(255, 4, 4, 5),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable: cartNotifier,
                    builder: (context, list, _) {
                      if (list.isEmpty) {
                        return const Text('cart is empty',
                            style: TextStyle(color: Colors.white));
                      }
                      return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          final data = list[index];
                          return Container(
                              margin: const EdgeInsets.only(bottom: 40),
                              height: size.height * 0.20,
                              width: size.width*30
                              ,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color.fromARGB(255, 245, 100, 100),
                              ),
                              child: Row(children: [
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  height: size.height*.20,
                                  width: size.width*.25,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(data.dishImage),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                SizedBox(
                                  width: size.width * 0.08,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          Text(
                                            data.dishName,
                                            style: GoogleFonts.irishGrover(
                                              textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                              onTap: () async {
                                                await CartRepository
                                                    .removeCart(data);
                                              },
                                              child: const Padding(
                                                padding:  EdgeInsets.only(left: 0),
                                                child: Icon(Icons.close),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Text(
                                      data.dishPrice,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await CartRepository
                                                .decreaseCartQuatity(data);
                                            // data.dishQuantity--;
                                            // setState(() {});
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: const BoxDecoration(
                                                color: Colors.white),
                                            child: const Center(
                                                child: Text(
                                              "-",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            )),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          data.dishQuantity.toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            await CartRepository
                                                .updateCartQuatity(data);
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: const BoxDecoration(
                                                color: Colors.white),
                                            child: const Center(
                                                child: Text(
                                              "+",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ]));
                        },
                      );
                    }),
              ),
              if (!showAddPreferenceButton)
                GestureDetector(
                  onTap: () {
                    if (userCancelled) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    } else {
                      _showPreferencePopup(context);
                    }
                  },
                  child: InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false);
                    },
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Total:",
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        // const Spacer(),
                        ValueListenableBuilder<int>(
                          valueListenable: totalNotifier,
                          builder: (context, total, child) {
                            return Text(
                              '₹$total',
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                        const Spacer(),
                        Container(
                          height: 60,
                          width: 200,
                          color: const Color.fromARGB(255, 6, 8, 6),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: Text("Add More",
                                style: GoogleFonts.irishGrover(
                                    textStyle: const TextStyle(
                                        fontSize: 28, color: Colors.white))),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              GestureDetector(
                onTap: () {
                  if (!showAddPreferenceButton) {
                    _showPreferencePopup(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Container(
                    height: 60,
                    width: 280,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color.fromARGB(255, 250, 248, 248)),
                    child: Center(
                        child: Text(
                      "completed",
                      style: GoogleFonts.abel(
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showCompletedPopup(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Order Completed"),
          content: const Text("Your order has been successfully completed."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showPreferencePopup(BuildContext context) async {
    String userPreference = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Your Preference"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  userPreference = value;
                },
                decoration: const InputDecoration(labelText: "Your Preference"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // ignore: avoid_print
                print("User's Preference: $userPreference");
                final order = CartRepository.makeOrder(userPreference);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TablebookScreen(model: order)));
                setState(() {
                  showAddPreferenceButton = false;
                });
              },
              child: const Text("Save"),
            ),
            TextButton(
              onPressed: () {
                final order = CartRepository.makeOrder(userPreference);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TablebookScreen(model: order)));
                setState(() {
                  userCancelled = false;
                });
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    ).then((_) {
      if (userSaved) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => TablebookScreen(dish: ,),
        //   ),
        // );
      }
    });
  }
}
