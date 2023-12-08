class Dishes {
  final String dishImage;
  final String dishName;
  final String dishPrice;
  final String dishDescription;
  final String dishCategory;
  final String dishId;
  final double dishRating;
  final bool isPopular;
 

  Dishes(
      {required this.dishImage,
      required this.dishName,
      required this.dishPrice,
      required this.dishDescription,
      required this.dishCategory,
      required this.dishId,
      required this.dishRating,
     
      required this.isPopular});
  factory Dishes.fromJson(Map<String, dynamic> json) {
    return Dishes(
      dishImage: json['imageUrl'] ?? '',
      dishName: json['dishName'] ?? '',
      dishPrice: json['dishPrice'] ?? '',
      dishDescription: json['dishDescription'] ?? '',
      dishCategory: json['dishCategory'] ?? '',
   
      dishId: json['dishId'] ?? '',
      dishRating: (json['dishRating'] as num?)?.toDouble() ?? 0.0,
      isPopular: json['isPopular'] ?? false,
    );
  }
}
