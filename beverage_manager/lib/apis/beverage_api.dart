import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:beverage_manager/models/beverage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BeverageApi {
  static String server = 'beverage-api.onrender.com';

  static Future<List<Beverage>> fetchBeverages() async {
    var url = Uri.https(server, '/api/beverages');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((beverage) => Beverage.fromJson(beverage))
          .toList();
    } else {
      throw Exception('Failed to load beverages');
    }
  }

  static Future<Beverage> fetchBeverage(String id) async {
    var url = Uri.https(server, '/api/beverages/get/$id');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Beverage.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load beverage');
    }
  }

  static Future<Beverage> createBeverage(
      Beverage beverage, File? imageFile) async {
    var url = Uri.parse('https://beverage-api.onrender.com/api/beverages/add');
    var request = http.MultipartRequest('POST', url);

    if (imageFile != null) {
      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile(
        'beverage_image',
        stream,
        length,
        filename: imageFile.path.split('/').last,
      );
      request.files.add(multipartFile);
    }

    Map<String, String> fields = {
      'name': beverage.beveragename,
      'sugar': beverage.sugar.toString(),
      'rating': beverage.rating.toString(),
      'scanned': beverage.scanned.toString(),
    };
    request.fields.addAll(fields);

    var response = await request.send(); // Send the request to the server
    if (response.statusCode == 200) {
      // Check if the request is successful
      var responseData = await response.stream
          .bytesToString(); // Convert the response stream to a string
      return Beverage.fromJson(json
          .decode(responseData)); // Convert the JSON data to a Beverage object
    } else {
      throw Exception(
          'Failed to create beverage'); // Throw an exception if the request fails
    }
  }

  //Method to store the image to assets folder
  static Future<void> saveImageToAssets(File imageFile, String fileName) async {
    // Use the correct path to save the image to the assets directory
    final Directory directory = Directory('assets'); //Create a directory object
    if (!await directory.exists()) {
      //Check if directory exists
      await directory.create(
          recursive: true); //Create a directory if one doesn't exist
    }
    if (!await directory.exists()) {
      //Check if directory exists
      throw Exception(
          'Failed to create the assets directory'); //Throw exc if failed
    }
    final File localImageFile =
        File('${directory.path}/$fileName'); // Create local image file
    await localImageFile.writeAsBytes(
        imageFile.readAsBytesSync()); // Write bytes to the image file
  }

  static Future<Beverage> updateBeverage(
      String id, Beverage beverage, File? image) async {
    var url =
        Uri.parse('https://beverage-api.onrender.com/api/beverages/update/$id');
    var request =
        http.MultipartRequest('PUT', url); //Create a multipart HTTP PUT request

    if (image != null) {
      //Check if an image file is provided
      var stream = http.ByteStream(
          image.openRead()); // Open a byte stream for the image file
      var length = await image.length(); // Get the length of the image file
      var multipartFile = http.MultipartFile(
        // Create a multipart file for the image
        'beverage_image', // Set the field name for the image
        stream, // Set the byte stream for the image
        length, // Set the length of the image
        filename:
            image.path.split('/').last, // Extract the filename from the path
      );
      request.files.add(multipartFile); // Add the multipart file to the request
    }

    Map<String, String> fields = {
      'name': beverage.beveragename,
      'sugar': beverage.sugar.toString(),
      'rating': beverage.rating.toString(),
      'scanned': beverage.scanned.toString(),
    };
    request.fields.addAll(fields);

    var response = await request.send(); // Send the request to the server
    if (response.statusCode == 200) {
      // Check if the request is successful
      var responseData = await response.stream
          .bytesToString(); // Convert the response stream to a string
      return Beverage.fromJson(json
          .decode(responseData)); // Convert the JSON data to a Beverage object
    } else {
      throw Exception(
          'Failed to update beverage'); // Throw an exception if the request fails
    }
  }

  static Future deleteBeverage(String id) async {
    var url = Uri.https(server, '/api/beverages/delete/$id');

    final http.Response response = await http.delete(url);
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to delete beverage');
    }
  }
}
