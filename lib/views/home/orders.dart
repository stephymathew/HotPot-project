import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hotpotproject/controller/hive/product_hive.dart';
import 'package:hotpotproject/views/home/home.dart';

// import 'package:hotpotproject/views/home/home.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    CartRepository.getPlacedOrder();
    super.initState();
  }

  //final Dishes dish;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 20, 22),
      appBar: AppBar(
        title: Text('Bill'),
        backgroundColor: const Color.fromARGB(225, 179, 19, 19),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: placeOrderNotifier,
                  builder: (context, list, _) {
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final data = list[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 40),
                          height: 150,
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color.fromARGB(255, 179, 19, 19),
                          ),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                height: 100,
                                width: 100,
                                decoration:  BoxDecoration(
                                  shape: BoxShape.circle,
                                image: DecorationImage(image: NetworkImage(data.dishImage))
                                ),
                              
                              ),
                              SizedBox(
                                width: size.width * 0.08,
                              ),
                              Column(
                                //  mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      data.dishName,
                                      style: GoogleFonts.irishGrover(
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  
                                  Text(
                                    'Quantity:${data.dishPrice} x ${data.dishQuantity}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    'price: ₹${int.parse(data.dishPrice) * data.dishQuantity}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: ValueListenableBuilder(
                                valueListenable: totalPlacedOredeNotifier,
                                builder: (context, total, _) =>
                                    Text('Your Total is ${total.toString()}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                                    
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    CartRepository.deleteAll();
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen()),
                                        (route) => false);
                                  },
                                  child: Text('Confirm')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'))
                            ],
                          ));
                },
                child: Container(
                  height: 60,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: const Center(
                      child: Text(
                    "Bill Payment",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
