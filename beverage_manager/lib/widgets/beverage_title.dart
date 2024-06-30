import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

typedef MyCallback = void Function();

class BeverageTile extends StatelessWidget {
  final String? beveragename, beverageImage;
  final MyCallback onTapped;

  const BeverageTile({
    Key? key,
    required this.beveragename,
    required this.beverageImage,
    required this.onTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Display the skeleton effect if the data is not available
    if (beveragename == null || beverageImage == null) {
      return _buildSkeleton();
    }

    String imageUrl =
        beverageImage!; // Assign the value of the variable beverageImage to the variable imageUrl
    String prefix =
        'https://beverage-api.onrender.com/api/beverages/'; // Initialize the variable prefix with the specified URL prefix
    return GestureDetector(
      onTap: () {
        onTapped();
      },
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              imageUrl = imageUrl.substring(prefix
                  .length), // Extract the substring from 'imageUrl' starting after the length of the 'prefix'
              height: 200,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 5,
          ),
          Text(
            beveragename!,
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          Container(
            height: 5,
          ),
          Container(
            height: 20,
          ),
        ],
      ),
    );
  }
}

Widget _buildSkeleton() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white,
        radius: 30,
      ),
      title: Container(
        height: 16,
        color: Colors.white,
      ),
      subtitle: Container(
        height: 12,
        color: Colors.white,
      ),
    ),
  );
}
