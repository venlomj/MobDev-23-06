import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BeverageSkeleton extends StatelessWidget {
  const BeverageSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6, // Adjust the number of skeleton items as needed
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {}, // Add an empty function for the onTap property
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                height: 5,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width * 0.75,
                  color: Colors.white,
                ),
              ),
              Container(
                height: 5,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: Colors.white,
                ),
              ),
              Container(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
