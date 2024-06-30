import 'dart:convert';

class Beverage {
  final String id;
  String beveragename;
  int sugar;
  int rating;
  bool scanned;
  String beverageImage;

  Beverage({
    required this.id,
    required this.beveragename,
    required this.sugar,
    required this.rating,
    required this.scanned,
    required this.beverageImage,
  });

  factory Beverage.fromJson(Map<String, dynamic> json) {
    String baseUrl = 'https://beverage-api.onrender.com/api/beverages/';
    String imageName = json['beverage_image'] as String? ??
        ''; // Assuming 'beverage_image' is the key for the image file name
    String imageUrl = '$baseUrl$imageName';

    return Beverage(
      id: json['_id'] as String? ?? '',
      beveragename: json['name'] as String? ?? '',
      sugar: json['sugar'] as int? ?? 0,
      rating: json['rating'] as int? ?? 0,
      scanned: json['scanned'] as bool? ?? false,
      beverageImage: imageUrl,
      // beverageImage: json['beverage_image'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': beveragename,
      'sugar': sugar,
      'rating': rating,
      'scanned': scanned,
      'beverage_image': beverageImage,
    };
  }
}
