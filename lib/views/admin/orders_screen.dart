import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotpotproject/controller/firebase/product_service/oder_service.dart';
import 'package:hotpotproject/model/order_models.dart';
import 'package:hotpotproject/views/admin/order_detail.dart';

class OrdersAdminScreen extends StatelessWidget {
  const OrdersAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Orders',style: TextStyle(color: Color.fromARGB(255, 7, 5, 5),fontSize: 30),),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 185, 18, 77),
          bottom: const TabBar(tabs: [
            Tab(
              child: Text('Pending',style: TextStyle(color: Colors.black,fontSize: 20),),
            ),
            Tab(
              child: Text('Delivered',style: TextStyle(color: Colors.black,fontSize: 20),),
            )
          ]),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Order').snapshots(),
            builder: (context, snapshot) {
              List<Orders> lists = [];
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                lists = [];
              } else {
                List<DocumentSnapshot> docs = snapshot.data!.docs;
                // final docs = snapshot.data as List<Map<String, dynamic>>;
                // print(docs.first.data());
                lists = docs
                    .map((e) =>
                        Orders.fromJson(e.data() as Map<String, dynamic>))
                    .toList();
              }
              return TabBarView(children: [
                ListBuilderOrder(
                    orders: lists
                        .where((order) => order.status == 'pending')
                        .toList()),
                ListBuilderOrder(
                    orders: lists
                        .where((order) => order.status != 'pending')
                        .toList())
              ]);
            }),
      ),
    );
  }
}

class ListBuilderOrder extends StatelessWidget {
  const ListBuilderOrder({super.key, required this.orders});
  final List<Orders> orders;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      //no data
    }
    return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          
          return Container(
            margin: const EdgeInsets.all(10),
            height: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: const Color.fromARGB(255, 58, 55, 58)),
            width: double.infinity,
            child: ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderDetailScreen(order: order))),
              title: Text('Table - ${order.table.toString()}',style: const TextStyle(color: Color.fromARGB(255, 5, 5, 5),fontSize: 20),),
              subtitle: Text(order.date,style: const TextStyle(color: Color.fromARGB(255, 209, 205, 205)),),
              trailing: order.status == 'pending'
                  ? ElevatedButton(
                      onPressed: () async {
                        await OrderRepository().updateOrder(order.orderId!);
                      },
                      child: const Text('Order Ready'))
                  : const SizedBox(),
            ),
          );
        });
  }
}
