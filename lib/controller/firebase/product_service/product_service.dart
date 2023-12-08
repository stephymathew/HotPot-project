import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hotpotproject/model/food_models.dart';

ValueNotifier<List<Dishes>> dishNotifier = ValueNotifier([]);

class Repository with ChangeNotifier {
  final FirebaseFirestore productInstance = FirebaseFirestore.instance;
  Future<void> addProduct(Dishes model) async {
    final CollectionReference data =
        productInstance.collection("ProductCollections");
    final DocumentReference doc = data.doc();
    final Map<String, dynamic> datas = {
      'imageUrl': model.dishImage,
      'dishPrice': model.dishPrice,
      'dishDescription': model.dishDescription,
      'dishName': model.dishName,
      'dishCategory': model.dishCategory,
      'dishId': doc.id,
      'dishRating': model.dishRating,
      'isPopular': model.isPopular,
    };

    await doc.set(datas);

    //doc.set(datas);
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<String> uploadImageAndGetUrl(String imagePath) async {
    try {
      final Reference ref = _storage
          .ref()
          .child('productImages')
          .child(DateTime.now().millisecondsSinceEpoch.toString());
      final UploadTask uploadTask = ref.putFile(File(imagePath));
      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Dishes>> getAllProduct() async {
    final CollectionReference response =
        productInstance.collection("ProductCollections");

    final responseData = await response.get();

    return responseData.docs.map((e) {
      final data = e.data() as Map<String, dynamic>;

      return Dishes.fromJson(data);
    }).toList();
  }

  Future<List<Dishes>> getProducsByCategory({required String category}) async {
    final CollectionReference response =
        productInstance.collection("ProductCollections");
    final responseData =
        await response.where('dishCategory', isEqualTo: category).get();
    return responseData.docs
        .map((dish) => Dishes.fromJson(dish.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> getProducs() async {
    List<Dishes> list = [];
    try {
      await productInstance
          .collection('ProductCollections')
          .get()
          .then((value) {
        list = value.docs.map((e) => Dishes.fromJson(e.data())).toList();
      });
    } on FirebaseException catch (e) {
      e;
    }
    dishNotifier.value = list;
    dishNotifier.notifyListeners();
  }

  Future<List<Dishes>> getPopularCategory() async {
    final collection = productInstance.collection('ProductCollections');
    final data = await collection.where('isPopular', isEqualTo: true).get();
    return data.docs.map((dish) => Dishes.fromJson(dish.data())).toList();
  }

  Future<void> updateProduct(dish) async {
    try {
      await FirebaseFirestore.instance
          .collection("ProductCollections")
          .doc(dish.dishId)
          .update({
        'imageUrl': dish.dishImage,
        'dishPrice': dish.dishPrice,
        'dishDescription': dish.dishDescription,
        'dishName': dish.dishName,
        'dishCategory': dish.dishCategory,
        'dishRating': dish.dishRating,
        'isPopular': dish.isPopular,
      });
    } catch (e) {
      e;
    }
  }

  Future<void> deleteProduct(dishId) async {
    try {
      await FirebaseFirestore.instance
          .collection("ProductCollections")
          .doc(dishId)
          .delete();
    } catch (e) {
      e;
    }
  }
}
