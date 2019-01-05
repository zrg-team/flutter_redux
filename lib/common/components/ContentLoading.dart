import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ContentLoading extends StatelessWidget {

  ContentLoading();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 8.0,
            color: Colors.white,
          ),
          Padding(
            padding:
              const EdgeInsets.symmetric(vertical: 4.0),
          ),
          Container(
            width: double.infinity,
            height: 8.0,
            color: Colors.white,
          ),
          Padding(
            padding:
              const EdgeInsets.symmetric(vertical: 4.0),
          ),
          Container(
            width: double.infinity,
            height: 8.0,
            color: Colors.white,
          ),
          Padding(
            padding:
              const EdgeInsets.symmetric(vertical: 4.0),
          ),
          Container(
            width: 100.0,
            height: 8.0,
            color: Colors.white,
          ),
          Padding(
            padding:
              const EdgeInsets.symmetric(vertical: 4.0),
          ),
          Container(
            width: double.infinity,
            height: 300,
            color: Colors.white,
          ),
          Container(
            width: double.infinity,
            height: 8.0,
            color: Colors.white,
          ),
          Padding(
            padding:
              const EdgeInsets.symmetric(vertical: 4.0),
          ),
          Container(
            width: double.infinity,
            height: 8.0,
            color: Colors.white,
          ),
          Padding(
            padding:
              const EdgeInsets.symmetric(vertical: 4.0),
          ),
          Container(
            width: 40.0,
            height: 8.0,
            color: Colors.white,
          ),
          Padding(
            padding:
              const EdgeInsets.symmetric(vertical: 4.0),
          )
        ]
      )
    );
  }
}