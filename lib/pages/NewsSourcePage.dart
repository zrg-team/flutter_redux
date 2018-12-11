import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:cat_dog/common/components/MainDrawer.dart';
import 'package:cat_dog/common/components/GradientAppBar.dart';
import 'package:cat_dog/pages/SubNewsPage.dart';

class NewsSourcePage extends StatefulWidget {
  NewsSourcePage({Key key}) : super(key: key);

  @override
  _NewsSourcePageState createState() => new _NewsSourcePageState();
}

class _NewsSourcePageState extends State<NewsSourcePage> {
  var sources = [
    {
      'name': 'Zing',
      'image': 'assets/zing.png',
      'url': 'https://m.baomoi.com/bao-tri-thuc-truc-tuyen-zing/p/119.epi'
    },
    {
      'name': 'VOV',
      'image': 'assets/vov.jpg',
      'url': 'https://m.baomoi.com/bao-vov-vov/p/65.epi'
    },
    {
      'name': 'Thanh Niên',
      'image': 'assets/thanhnien.jpg',
      'url': 'https://m.baomoi.com/bao-thanh-nien-thanh-nien/p/19.epi'
    },
    {
      'name': 'Lao Động',
      'image': 'assets/laodong.jpg',
      'url': 'https://m.baomoi.com/bao-lao-dong-lao-dong/p/12.epi'
    },
    {
      'name': 'Vietnam Plus',
      'image': 'assets/vietnamplus.jpg',
      'url': 'https://baomoi.com/bao-vietnamplus-vietnamplus/p/293.epi'
    },
    {
      'name': 'Vietnam Net',
      'image': 'assets/vietnamnet.png',
      'url': 'https://baomoi.com/bao-vietnamnet-vietnamnet/p/23.epi'
    },
    {
      'name': 'VTC',
      'image': 'assets/vtc.png',
      'url': 'https://baomoi.com/bao-vtc-news-vtc/p/83.epi'
    },
    {
      'name': 'SaoStart',
      'image': 'assets/saostart.jpg',
      'url': 'https://baomoi.com/saostar-saostar/p/329.epi'
    },
    {
      'name': 'VN Media',
      'image': 'assets/vnmedia.png',
      'url': 'https://baomoi.com/vnmedia-vnmedia/p/22.epi'
    },
    {
      'name': 'ICT News',
      'image': 'assets/ictnews.png',
      'url': 'https://baomoi.com/ictnews-ictnews/p/107.epi'
    },
    {
      'name': 'Tiền Phòng',
      'image': 'assets/tienphong.png',
      'url': 'https://baomoi.com/bao-tien-phong-tien-phong/p/20.epi'
    },
    {
      'name': 'Kiến Thức',
      'image': 'assets/kienthuc.jpeg',
      'url': 'https://baomoi.com/bao-kien-thuc-kien-thuc/p/180.epi'
    }
  ];
  bool change = false;
  final GlobalKey<ScaffoldState> _mainKey = new GlobalKey<ScaffoldState>();

  CircleAvatar _loadAvatar(var url) {
    return new CircleAvatar(
      backgroundColor: Colors.transparent,
      backgroundImage: new AssetImage(url),
      radius: 40.0,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _mainKey,
      backgroundColor: AppColors.commonBackgroundColor,
      appBar: new PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: new GradientAppBar(
          'Nguồn Tin',
          Icon(
            Icons.dehaze,
            size: 32
          ),
          () => _mainKey.currentState.openDrawer(),
          Icon(
            Icons.home,
            size: 32
          ),
          () {
            if (Navigator.of(context).canPop()) {
              return Navigator.of(context).pop();
            }
            Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
          }
        ),
      ),
      drawer: new MainDrawer(),
      body: new GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 25.0),
        padding: const EdgeInsets.all(10.0),
        itemCount: 12,
        itemBuilder: (BuildContext context, int index) {
          return new GridTile(
            footer: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Flexible(
                    child: new SizedBox(
                      height: 16.0,
                      width: 100.0,
                      child: new Text(
                        sources[index]['name'],
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.white
                        )
                      ),
                    ),
                  )
                ]),
            child: new Container(
              height: 500.0,
              padding: const EdgeInsets.only(bottom: 5.0),
              child: new GestureDetector(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new SizedBox(
                      height: 100.0,
                      width: 100.0,
                      child: new Row(
                        children: <Widget>[
                          new Stack(
                            children: <Widget>[
                              new SizedBox(
                                child: new Container(
                                  child: _loadAvatar(
                                    sources[index]['image']),
                                  padding: const EdgeInsets.only(
                                    left: 10.0, top: 12.0, right: 10.0),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SubNewsPage(category: {
                        'url': sources[index]['url'],
                        'title': sources[index]['name']
                      }),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}