// import 'dart:developer';

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hotpotproject/controller/firebase/product_service/product_service.dart';
import 'package:hotpotproject/model/food_models.dart';
// import 'package:hotpotproject/views/admin/foodadd.dart';

import 'package:hotpotproject/views/admin/home2.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FoodUpdateScreen extends StatefulWidget {
  const FoodUpdateScreen({
    super.key,
    required this.dish,
  });
  final Dishes dish;

  @override
  FoodUpdateScreenState createState() => FoodUpdateScreenState();
}

class FoodUpdateScreenState extends State<FoodUpdateScreen> {
  // String selectedValue = 'burger';
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _prizeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String selectedValue = '';
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _confirmDelete() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await Repository().deleteProduct(widget.dish.dishId);
                Navigator.pop(context);
                Navigator.pop(
                    context); 
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
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
  void initState() {
    _nameController.text = widget.dish.dishName;
    _prizeController.text = widget.dish.dishPrice;
    _descriptionController.text = widget.dish.dishDescription;
    selectedValue = widget.dish.dishCategory;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 22, 21, 24),
        appBar: AppBar(
          title: Text(widget.dish.dishName),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  children: [
                    const Center(
                      child: Text(
                        "Update Image",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 134, 21, 21),
                      ),
                      child: IconButton(
                          onPressed: () async {
                            await Repository()
                                .deleteProduct(widget.dish.dishId);
                            Navigator.pop(context);
                            _confirmDelete();
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _pickImage();
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: _image != null
                        ? DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit.cover,
                          )
                        : DecorationImage(
                            image: NetworkImage(widget.dish.dishImage),
                            fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "  Name",
                      style: GoogleFonts.aboreto(
                        textStyle: const TextStyle(color: Colors.white),
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  SizedBox(
                    height: 40,
                    width: 200,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _nameController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.red,
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !value.contains(widget.dish.dishName)) {
                          return 'please enter a valid name';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "   Price",
                    style: GoogleFonts.aboreto(
                      textStyle: const TextStyle(fontSize: 18),
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 40),
                  SizedBox(
                    height: 40,
                    width: 200,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _prizeController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.red,
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !value.contains(widget.dish.dishPrice)) {
                          return 'please enter a valid price';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
                width: 200,
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
                  height: 150,
                  child: TextFormField(
                    controller: _descriptionController,
                    keyboardType: TextInputType.text,
                    maxLines: 8,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.red,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !value.contains(widget.dish.dishDescription)) {
                        return 'please enter  description';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                height: 40,
                width: 120,
                child: ElevatedButton(
                    onPressed: () async {
                      // if (_image == null) {
                      //   print("image not changed");
                      //   return;
                      // }

                      final imageUrl = _image != null
                          ? await Repository()
                              .uploadImageAndGetUrl(_image!.path)
                          : widget.dish.dishImage;
                      if (_nameController.text.isNotEmpty ||
                          _prizeController.text.isNotEmpty ||
                          _descriptionController.text.isNotEmpty ||
                          category.isNotEmpty ||
                          imageUrl.isNotEmpty ||
                          selectedValue.isNotEmpty) {
                        final collectedData = Dishes(
                          dishImage: imageUrl,
                          dishName: _nameController.text,
                          dishPrice: _prizeController.text,
                          dishDescription: _descriptionController.text,
                          dishCategory: selectedValue,
                          dishId: widget.dish.dishId,
                          dishRating: widget.dish.dishRating,
                          isPopular: widget.dish.isPopular,
                        );

                        await Repository().updateProduct(collectedData);
                        // print('imageurl: $imageUrl');
                        _showSnackbar('food updated uccessfully!');

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home2Screen()),
                        );
                      } else {
                        return;
                      }
                    },
                    child: const Text(
                      "Update",
                    )),
                // child: ElevatedButton(
                //   onPressed: () async {
                //     await Repository().updateProduct(Dishes(
                //       dishId: widget.dish.dishId,
                //       dishName: _nameController.text,
                //       dishDescription: _descriptionController.text,
                //       dishCategory: selectedValue,
                //       dishPrice: _prizeController.text,
                //       dishImage: File(_image),
                //       dishRating: 4.5,
                //       isPopular: true,
                //     ));

                //     Navigator.pushReplacement(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => Home2Screen(),
                //       ),
                //     );
                //   },
                //   child: Text('Update'),

                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
