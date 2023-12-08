import 'package:flutter/material.dart';
import 'package:hotpotproject/controller/firebase/product_service/oder_service.dart';
import 'package:hotpotproject/controller/firebase/product_service/product_service.dart';
import 'package:hotpotproject/model/food_models.dart';

import 'package:hotpotproject/model/order_models.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key, required this.order});
  final Orders order;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    getDish();
    super.initState();
  }

  List<Dishes> dishes = [];
  void getDish() {
    dishes.clear();
    dishes = dishNotifier.value
        .where((dish) => widget.order.dishId.contains(dish.dishId))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 160, 19, 66),
        title: Row(
          children: [
            const Text(
              "Table: ",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              widget.order.table.toString(),
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          // const Padding(
          //   padding: EdgeInsets.all(15),
          //   child: Text("Table 1",style: TextStyle(color: Colors.amber,fontSize: 25),),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.order.dishId.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(20),
                //  height: 130,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 73, 71, 72),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: ListTile(leading: CircleAvatar(backgroundImage: NetworkImage(dishes[index].dishImage),),title: Text(
                              dishes[index].dishName,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),subtitle: Text(
                            "Quntity: ${widget.order.dishQuantity[index].toString()}",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),)
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            height: 130,
            width: double.infinity,
            decoration: const BoxDecoration(
                borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
                color: Colors.pink),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Preference",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      )),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.order.preference,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                      ))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 50,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: ElevatedButton(
                  onPressed: () async {
                    await OrderRepository().updateOrder(widget.order.orderId!);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "completed",
                    style: TextStyle(fontSize: 14),
                  )),
            ),
          )
        ],
      ),
    );
  }
}



