

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hotpotproject/views/carosals/carosal1.dart';
import 'package:hotpotproject/views/carosals/carosal3.dart';
import 'package:hotpotproject/views/carosals/carosol2.dart';


class Maincarosal extends StatefulWidget {
  const Maincarosal({super.key});

  @override
  State<Maincarosal> createState() => _MaincarosalState();
}

class _MaincarosalState extends State<Maincarosal> {
  List<Widget> pages = [
    const Carosal1(),
    const Carosal2(),
    const Carosal3(),
  ];
  final CarouselController _controller = CarouselController();
  int current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 22, 21, 21),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: pages,
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                aspectRatio: 1 / 2,
                viewportFraction: 0.9,
                onPageChanged: (index, reason) {
                  setState(() {
                    current = index;
                  });
                },
              ),
              carouselController: _controller,
            ),
            Positioned(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pages.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin:
                          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness == Brightness.dark
                                  ? const Color.fromARGB(255, 10, 10, 10)
                                  : const Color.fromARGB(255, 190, 238, 15))
                              .withOpacity(current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
