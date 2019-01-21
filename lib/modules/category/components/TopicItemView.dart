import 'package:flutter/material.dart';
import 'package:cat_dog/styles/colors.dart';

class TopicItemView extends StatelessWidget {
  TopicItemView(this.news, this.onTap);
  final dynamic news;
  final Function onTap;

  BoxDecoration _buildShadowAndRoundedCorners() {
    return BoxDecoration(
      color: AppColors.itemDefaultColor.withOpacity(0.4),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          spreadRadius: 2.0,
          blurRadius: 10.0,
          // color: Colors.black26,
        ),
      ],
    );
  }

  Widget _buildThumbnail() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Stack(
        children: <Widget>[
          Image.network(news['image'])
          // Positioned(
          //   bottom: 12.0,
          //   right: 12.0,
          //   child: _buildPlayButton(),
          // ),
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 4.0, right: 4.0),
      child: Text(
        news['heading'],
        style: TextStyle(color: Colors.white.withOpacity(0.85)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        onTap(news);
      },
      child: Container(
        width: 175.0,
        height: 245,
        padding: const EdgeInsets.all(5.0),
        margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        decoration: _buildShadowAndRoundedCorners(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(flex: 3, child: _buildThumbnail()),
            Flexible(flex: 2, child: _buildInfo()),
          ]
        )
      )
    );
  }
}