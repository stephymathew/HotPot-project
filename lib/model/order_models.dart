class Orders {
  List<String> dishId;
  List<int> dishQuantity;
  final String? orderId;
  final String date;
  int? table;
  String preference;
  String status;

  Orders({
    required this.dishId,
    required this.dishQuantity,
    this.orderId,
    required this.date,
    this.table,
    required this.preference,
    this.status='pending'
  });
  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      dishId: List<String>.from(json['dishId'] ?? []),
      dishQuantity: List<int>.from(json['dishQuantity'] ?? []),
      orderId: json['orderId'] ?? '',
      date: json['date'] ?? '',
      table: json['table'] ?? 1,
      preference: json['preference'] ?? '',
      status: json['status']??'pending'
    );
  }
}
