import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotpotproject/controller/firebase/product_service/oder_service.dart';
import 'package:hotpotproject/controller/hive/product_hive.dart';
import 'package:hotpotproject/model/order_models.dart';
import 'package:hotpotproject/views/home/confirm.dart';

class TablebookScreen extends StatefulWidget {
  const TablebookScreen({
    super.key,
    required this.model,
  });
  final Orders model;

  @override
  TablebookScreenState createState() => TablebookScreenState();
}

class TablebookScreenState extends State<TablebookScreen> {
  int selectedTable = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 7, 7),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          "Select Your Seat",
          style: GoogleFonts.abel(
              textStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    selectTable(1);
                  },
                  child: Container(
                    height: 100,
                    width: 350,
                    color: selectedTable == 1 ? Colors.grey : Colors.amber,
                    child: const Center(child: Text("TABLE 1")),
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  selectTable(2);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10, top: 10),
                  child: Container(
                    height: 300,
                    width: 100,
                    color: selectedTable == 2 ? Colors.grey : Colors.amber,
                    child: const Center(child: Text("TABLE 2")),
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  selectTable(3);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        color: selectedTable == 3 ? Colors.grey : Colors.amber,
                        child: const Center(child: Text("TABLE 3")),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: InkWell(
                          onTap: () {
                            selectTable(4);
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            color:
                                selectedTable == 4 ? Colors.grey : Colors.amber,
                            child: const Center(child: Text("TABLE 4")),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  selectTable(5);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, top: 10),
                  child: Container(
                    height: 300,
                    width: 100,
                    color: selectedTable == 5 ? Colors.grey : Colors.amber,
                    child: const Center(child: Text("TABLE 5")),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: InkWell(
              onTap: () {
                selectTable(6);
              },
              child: Container(
                height: 180,
                width: 350,
                color: selectedTable == 6 ? Colors.grey : Colors.amber,
                child: const Center(child: Text("TABLE 6")),
              ),
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  selectTable(7);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20),
                  child: Container(
                    height: 100,
                    width: 150,
                    color: selectedTable == 7 ? Colors.grey : Colors.amber,
                    child: const Center(child: Text("TABLE 7")),
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  selectTable(8);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, right: 20),
                  child: Container(
                    height: 100,
                    width: 150,
                    color: selectedTable == 8 ? Colors.grey : Colors.amber,
                    child: const Center(child: Text("TABLE 8")),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void selectTable(int tableNumber) async {
    setState(() {
      selectedTable = tableNumber;
    });
    widget.model.table = tableNumber;
    final add = await OrderRepository().addOrders(widget.model);
    await CartRepository.placeOrder();
    Future.delayed(const Duration(seconds: 1), () {
      if (add) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ConfirmScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("please try again"), backgroundColor: Colors.red));
      }
    });
  }
}
