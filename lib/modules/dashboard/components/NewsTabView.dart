import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/pages/ReadingPage.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:cat_dog/pages/LoadingPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cat_dog/common/components/NewsList.dart';

class NewsTabView extends StatefulWidget {
  final Function saveNews;
  final Function getHotNews;
  final Function getLatestNews;
  final Function refreshCallback;
  const NewsTabView({
    Key key,
    this.saveNews,
    this.refreshCallback,
    this.getHotNews,
    this.getLatestNews
  }) : super(key: key);

  @override
  _NewsTabViewState createState() => new _NewsTabViewState();
}

class _NewsTabViewState extends State<NewsTabView> with SingleTickerProviderStateMixin {
  bool loading = true;
  GlobalKey pageKey = new GlobalKey();

  AnimationController animationController;
  Animation<double> animation;

  ScrollController scrollController = new ScrollController();
  CarouselSlider instance;
  @override
  void initState() {
    super.initState();
    getNews();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    animation = CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);
    widget.refreshCallback(() async {
      await getNews();
      scrollController.animateTo(
        0,
        duration: new Duration(milliseconds: 400),
        curve: Curves.easeInOut
      );
    });
    // TODO: Fix it ?
    double lastOffset = 0;
    bool onScrollDown;
    double changeOffset = 0;
    scrollController.addListener(() {
      if (scrollController.offset < 5) {
        onScrollDown = false;
        changeOffset = 0;
        if (!animationController.isAnimating) {
          animationController.reverse();
        }
        return true;
      }
      bool stateScrollDown = scrollController.offset - lastOffset > 0;
      if (onScrollDown == null && stateScrollDown) {
        onScrollDown = true;
        animationController.forward();
      } else if (onScrollDown == null && !stateScrollDown) {
        onScrollDown = false;
        animationController.reverse();
      } else if (onScrollDown && !stateScrollDown) {
        changeOffset += 1;
      } else if (!onScrollDown && stateScrollDown) {
        changeOffset += 1;
      }
      if (changeOffset >= 10 && onScrollDown && !stateScrollDown) {
        changeOffset = 0;
        onScrollDown = false;
        if (!animationController.isAnimating) {
          animationController.reverse();
        }
      } else if (changeOffset >= 10 && !onScrollDown && stateScrollDown) {
        changeOffset = 0;
        onScrollDown = true;
        if (!animationController.isAnimating) {
          animationController.forward();
        }
      }
      lastOffset = scrollController.offset;
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  getNews () async {
    try {
      widget.getLatestNews();
      List<dynamic> hots = await widget.getHotNews();
      instance = CarouselSlider(
        items: hots.map((item) {
          return new Container(
            margin: EdgeInsets.all(5.0),
            width: MediaQuery.of(pageKey.currentContext).size.width - 40,
            decoration: new BoxDecoration(
              color: AppColors.commonBackgroundColor
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Container(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: NetworkImage(
                          item['image']
                        ),
                      fit: BoxFit.cover
                    )
                  ),
                  child: Container(
                    alignment: Alignment(-0.9, 0.8),
                    child: new FlatButton(
                      child: Text(
                        item['heading'],
                        style: new TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0
                        )
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ReadingPage(news: item)
                          )
                        );
                      }
                    )
                  )
                )
            )
          );
        }).toList(),
        autoPlay: true,
        autoPlayCurve: Curves.fastOutSlowIn
      );
    } catch (err) {
    }
    Future.delayed(const Duration(milliseconds: 1000), () async {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new LoadingPage(
      key: pageKey,
      loading: loading,
      component: new Flex(
        direction: Axis.vertical,
        children: <Widget>[
          new NewsCarouselAnimated(animation: animation, instance: instance),
          new Expanded(
            child: DefaultTabController(
              length: 2,
              child: new Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  new Container(
                    decoration: BoxDecoration(
                      color: AppColors.commonBackgroundColor
                    ),
                    child: TabBar(
                      tabs: [
                        Tab(
                          child: new Text('Tin Nóng', style: TextStyle( color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold ))
                        ),
                        Tab(
                          child: new Text('Tin Mới', style: TextStyle( color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold ))
                        )
                      ]
                    )
                  ),
                  new Expanded(
                    child: TabBarView(
                      children: [
                        new Container(
                          // height: MediaQuery.of(context).size.height - 476,
                          decoration: new BoxDecoration(
                            color: AppColors.commonBackgroundColor
                          ),
                          child: new StoreConnector<AppState, dynamic>(
                            converter: (Store<AppState> store) {
                              return store.state.dashboard.hot;
                            },
                            builder: (BuildContext context, news) {
                              return new NewsList(news ?? [], scrollController, widget);
                            }
                          )
                        ),
                        new Container(
                          // height: MediaQuery.of(context).size.height - 476,
                          decoration: new BoxDecoration(color: AppColors.commonBackgroundColor),
                          child: new StoreConnector<AppState, dynamic>(
                            converter: (Store<AppState> store) {
                              return store.state.dashboard.news;
                            },
                            builder: (BuildContext context, news) {
                              return new NewsList(news ?? [], scrollController, widget);
                            }
                          )
                        )
                      ]
                    )
                  )
                ]
              )
            )
          )
        ],
      )
    );
  }
}

class NewsCarouselAnimated extends AnimatedWidget {
  // The Tweens are static because they don't change.
  static final _sizeTween = Tween<double>(begin: 211.0, end: 0.0);
  final dynamic instance;
  NewsCarouselAnimated({Key key, Animation<double> animation, dynamic instance})
    : instance = instance,
    super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Container(
      decoration: BoxDecoration(color: AppColors.commonBackgroundColor),
      child: instance,
      width: MediaQuery.of(context).size.width,
      height: _sizeTween.evaluate(animation)
    );
  }
}