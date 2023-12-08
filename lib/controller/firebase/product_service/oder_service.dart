import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotpotproject/model/order_models.dart';

class OrderRepository {
  final FirebaseFirestore orderInstance = FirebaseFirestore.instance;
  Future<bool> addOrders(Orders model) async {
    try {
      final CollectionReference data = orderInstance.collection("Order");
      final DocumentReference doc = data.doc();
      final Map<String, dynamic> datas = {
        'dishId': model.dishId,
        'dishQuantity': model.dishQuantity,
        'orderId': doc.id,
        'date': model.date,
        'table': model.table,
        'preference': model.preference,
        'status': 'pending'
      };
      await doc.set(datas);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateOrder(String id) async {
    try {
      final CollectionReference data = orderInstance.collection("Order");
      final DocumentReference doc = data.doc(id);
      await doc.update({'status': 'delivered'});
      return true;
    } catch (e) {
      return false;
    }
  }
}
