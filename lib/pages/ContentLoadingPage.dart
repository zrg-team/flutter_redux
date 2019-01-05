import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ContentLoadingPage extends StatefulWidget {
  final Widget component;
  final bool loading;
  const ContentLoadingPage({
    Key key,
    this.component,
    this.loading
  }) : super(key: key);

  @override
  _ContentLoadingPageState createState() => new _ContentLoadingPageState();
}

class _ContentLoadingPageState extends State<ContentLoadingPage> {
  _ContentLoadingPageState({Key key});

  @override
  Widget build(BuildContext context) {
    if (widget.loading) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Column(
              children: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
              .map((_) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48.0,
                      height: 48.0,
                      color: Colors.white,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: 40.0,
                            height: 8.0,
                            color: Colors.white,
                          )
                        ]
                      )
                    )
                  ]
                )
              ))
              .toList(),
            )
          )
        )
      );
    }
    return widget.component;
  }
}