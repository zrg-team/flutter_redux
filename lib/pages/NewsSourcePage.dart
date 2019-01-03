import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:cat_dog/common/components/GradientAppBar.dart';
import 'package:cat_dog/common/configs.dart';
import 'package:cat_dog/common/utils/navigation.dart';

class NewsSourcePage extends StatefulWidget {
  NewsSourcePage({Key key}) : super(key: key);

  @override
  _NewsSourcePageState createState() => new _NewsSourcePageState();
}

class _NewsSourcePageState extends State<NewsSourcePage> {
  var sources = SOURCE_NEWS;
  bool change = false;
  final GlobalKey<ScaffoldState> _mainKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _mainKey,
      backgroundColor: AppColors.commonBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: new GradientAppBar(
          'Nguồn Tin',
          Icon(
            Icons.arrow_back,
            size: 32
          ),
          () {
            navigationPop(context);
          },
          null,
          () async {
          }
        )
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 25.0),
        padding: const EdgeInsets.all(10.0),
        itemCount: 12,
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            footer: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: SizedBox(
                    height: 16.0,
                    width: 100.0,
                    child: Text(
                      sources[index]['name'],
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[500]
                      )
                    ),
                  ),
                )
            ]),
            child: Container(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: FlatButton(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white
                  ),
                  child: Center(
                    child: Image.asset(
                      sources[index]['image'],
                      fit: BoxFit.cover,
                    )
                  )
                ),
                onPressed: () {
                  pushByName('/subview', context, {
                    'view': {
                      'url': sources[index]['url'],
                      'title': sources[index]['name']
                    }
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}