import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hotpotproject/model/food_models.dart';
import 'package:hotpotproject/model/hive_model.dart';
import 'package:hotpotproject/model/order_models.dart';

ValueNotifier<List<Products>> cartNotifier = ValueNotifier([]);
ValueNotifier<List<Products>> placeOrderNotifier = ValueNotifier([]);

ValueNotifier<int> totalNotifier = ValueNotifier(0);
ValueNotifier<int> totalPlacedOredeNotifier = ValueNotifier(0);

class CartRepository with ChangeNotifier {
  static String dbName = "cartDb";
  static Future addToCart(Dishes dish) async {
    final Box<Products> db = await Hive.openBox(dbName);
    Products? isContains;
    for (var dishdb in db.values) {
      if (dishdb.dishId == dish.dishId) {
        isContains = dishdb;
      }
    }
    if (isContains != null) {
      await updateCartQuatity(isContains);
    } else {
      final Products product = Products(
          id: DateTime.now().day +
              DateTime.now().hour +
              DateTime.now().minute +
              DateTime.now().microsecond,
          dishId: dish.dishId,
          dishImage: dish.dishImage,
          dishName: dish.dishName,
          dishPrice: dish.dishPrice.split('/').first,
          dishQuantity: 1);
      await db.put(product.id, product);
      cartNotifier.value.add(product);
      totalNotifier.value += int.parse(dish.dishPrice.split('/').first);
      cartNotifier.notifyListeners();
      totalNotifier.notifyListeners();
    }
  }

  static Future getCart() async {
    cartNotifier.value.clear();
    totalNotifier.value = 0;
    final Box<Products> db = await Hive.openBox(dbName);
    for (var value in db.values) {
      if (!value.ordered) {
        cartNotifier.value.add(value);
        int total = value.dishQuantity * int.parse(value.dishPrice);
        totalNotifier.value += total;
      }
    }
    cartNotifier.notifyListeners();
    totalNotifier.notifyListeners();
  }

  static Future removeCart(Products products) async {
    final Box<Products> db = await Hive.openBox(dbName);
    await db.delete(products.id);
    cartNotifier.value.removeWhere((element) => element.id == products.id);
    int total = products.dishQuantity * int.parse(products.dishPrice);
    totalNotifier.value -= total;
    cartNotifier.notifyListeners();
    totalNotifier.notifyListeners();
  }

  static Future updateCartQuatity(Products products) async {
    products.dishQuantity++;
    final Box<Products> db = await Hive.openBox(dbName);
    await db.put(products.id, products);
    totalNotifier.value += int.parse(products.dishPrice);
    await getCart();
  }

  static Future decreaseCartQuatity(Products products) async {
    if (products.dishQuantity == 1) {
      return await removeCart(products);
    }
    products.dishQuantity--;
    final Box<Products> db = await Hive.openBox(dbName);
    await db.put(products.id, products);
    totalNotifier.value -= int.parse(products.dishPrice);

    await getCart();
  }

  static Orders makeOrder(String preference) {
    List<String> dishId = [];
    List<int> dishQuantity = [];
    for (var dish in cartNotifier.value) {
      dishId.add(dish.dishId);
      dishQuantity.add(dish.dishQuantity);
    }
    return Orders(
        dishId: dishId,
        dishQuantity: dishQuantity,
        date: DateTime.now().toString(),
        preference: preference);
  }

  static placeOrder() async {
    final Box<Products> db = await Hive.openBox(dbName);
    List<Products> items = [];
    for (var item in db.values) {
      items.add(item..ordered = true);
    }
    await db.clear();
    await db.addAll(items);
    await getCart();
    await getPlacedOrder();
  }

  static Future getPlacedOrder() async {
    final Box<Products> db = await Hive.openBox(dbName);
    totalPlacedOredeNotifier.value = 0;
    placeOrderNotifier.value.clear();
    for (var item in db.values) {
      if (item.ordered) {
        placeOrderNotifier.value.add(item);
        totalPlacedOredeNotifier.value +=
            (int.parse(item.dishPrice) * item.dishQuantity);
      }
    }
    totalPlacedOredeNotifier.notifyListeners();
    placeOrderNotifier.notifyListeners();
  }

  static deleteAll() async {
    final Box<Products> db = await Hive.openBox(dbName);
    await db.clear();
    await getCart();
    await getPlacedOrder();
  }
}
