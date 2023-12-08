// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hotpotproject/controller/firebase/product_service/product_service.dart';
import 'package:hotpotproject/model/food_models.dart';

import 'package:hotpotproject/views/admin/home2.dart';

import 'package:image_picker/image_picker.dart';

class FoodaddingScreen extends StatefulWidget {
  const FoodaddingScreen({super.key, required String tabLabel});

  @override
  FoodaddingScreenState createState() => FoodaddingScreenState();
}

class FoodaddingScreenState extends State<FoodaddingScreen> {
  String selectedValue = 'burger';

  final List<String> category = [
    'burger',
    'pizza',
    'sandwich',
    'tea',
    'juices',
    'mojitos',
    'shakes',
    'cooldrinks',
    'popoular',
  ];
  File? _image;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  bool isPopular = false;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
 void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    log('rebuilding');

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 35, 36, 36),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  "Add Image",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: _image != null
                            ? DecorationImage(
                                image: FileImage(_image!),
                                fit: BoxFit.cover,
                              )
                            : const DecorationImage(
                                image: AssetImage(
                                    "asset/image/close-up-burger-with-black-background_23-2148234990.webp"),
                                fit: BoxFit.cover,
                              ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      right: 20,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt,
                            color: Colors.amber, size: 45),
                        onPressed: () {
                          _pickImage();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Name     ",
                      style: GoogleFonts.aboreto(
                        textStyle: const TextStyle(color: Colors.white),
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 25),
                  SizedBox(
                    height: 30,
                    width: 200,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: nameController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "   Price",
                    style: GoogleFonts.aboreto(
                      textStyle: const TextStyle(fontSize: 18),
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 43,
                  ),
                  SizedBox(
                    height: 30,
                    width: 200,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: priceController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Category   ",
                      style: GoogleFonts.aboreto(
                        textStyle: const TextStyle(color: Colors.white),
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: DropdownButton<String>(
                      dropdownColor: const Color.fromARGB(255, 244, 76, 54),
                      value: selectedValue,
                      onChanged: (String? value) {
                        if (value != null) {
                          setState(() {
                            selectedValue = value;
                            // print(selectedValue);
                          });
                        }
                      },
                      items: category.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(
                            category,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Description",
                style: GoogleFonts.aboreto(
                  textStyle: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: TextField(
                    controller: descriptionController,
                    keyboardType: TextInputType.text,
                    maxLines: 8,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.red,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    title: const Text(
                      'popular',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    leading: Checkbox(
                      value: isPopular,
                      onChanged: (value) {
                        setState(() {
                          isPopular = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                    onPressed: () async {
                      if (_image == null) {
                        // print("image null");
                        return;
                      }
                      final imageUrl =
                          await Repository().uploadImageAndGetUrl(_image!.path);
                      if (nameController.text.isNotEmpty ||
                          priceController.text.isNotEmpty ||
                          descriptionController.text.isNotEmpty ||
                          category.isNotEmpty ||
                          imageUrl.isNotEmpty ||
                          selectedValue.isNotEmpty) {
                        final collectedData = Dishes(
                          dishImage: imageUrl,
                          dishName: nameController.text,
                          dishPrice: priceController.text,
                          dishDescription: descriptionController.text,
                          dishCategory: selectedValue,
                          dishId: '',
                          dishRating: 4,
                          isPopular: isPopular,
                        );

                        await Repository().addProduct(collectedData);
                        _showSnackbar('food added uccessfully');

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ( BuildContext context) => const Home2Screen(
                            
                            ),
                          ),
                        );
                      } else {
                        // print("not added");
                        return;
                      }
                    },
                    child: const Text("add", style: TextStyle(fontSize: 25))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
