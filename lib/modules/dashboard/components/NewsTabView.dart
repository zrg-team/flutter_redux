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
  final Function getMoreHotNews;
  final Function getMoreLatestNews;
  final BuildContext scaffoldContext;
  const NewsTabView({
    Key key,
    this.saveNews,
    this.refreshCallback,
    this.getHotNews,
    this.getLatestNews,
    this.scaffoldContext,
    this.getMoreHotNews,
    this.getMoreLatestNews
  }) : super(key: key);

  @override
  _NewsTabViewState createState() => new _NewsTabViewState();
}

class _NewsTabViewState extends State<NewsTabView> with TickerProviderStateMixin {
  int tabIndex = 0;
  bool loading = true;
  int pageHot = 1;
  int pageNews = 1;
  bool onLoadMoreHot = false;
  bool onLoadMoreNews = false;
  GlobalKey pageKey = new GlobalKey();
  AnimationController animationController;
  Animation<double> animation;
  ScrollController scrollController = new ScrollController();
  TabController tabControllder;
  TabController tabbarControllder;
  CarouselSlider carouselInstance;

  @override
  void initState() {
    super.initState();
    getAllNews();
    // Animation
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    animation = CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);
    widget.refreshCallback(() async {
      await getAllNews();
      scrollController.animateTo(
        0,
        duration: new Duration(milliseconds: 400),
        curve: Curves.easeInOut
      );
    });
    // Tab Events
    tabControllder = new TabController(length: 2, vsync: this);
    tabbarControllder = new TabController(length: 2, vsync: this);
    tabbarControllder.addListener(() {
      tabControllder.animateTo(tabbarControllder.index);
    });
    tabControllder.addListener(() {
      tabbarControllder.animateTo(tabControllder.index);
      tabIndex = tabControllder.index;
    });
    // Scroll Events
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
      } else {
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
      }

      if (scrollController.offset >= scrollController.position.maxScrollExtent - 100) {
        if (tabIndex == 0 && !onLoadMoreHot) {
          pageHot += 1;
          onLoadMoreHot = true;
          getMoreHots();
        } else if (tabIndex == 1 && !onLoadMoreNews) {
          pageNews += 1;
          onLoadMoreNews = true;
          getMoreNews();
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(() {});
    tabControllder.removeListener(() {});
    tabbarControllder.removeListener(() {});

    tabControllder.dispose();
    scrollController.dispose();
    tabbarControllder.dispose();
    super.dispose();
  }

  CarouselSlider buildCarousel (List<dynamic> hots) {
    return CarouselSlider(
      items: hots.map((item) {
        return new Container(
          margin: EdgeInsets.all(5.0),
          width: MediaQuery.of(pageKey.currentContext).size.width - 40,
          height: 200,
          decoration: new BoxDecoration(
            color: AppColors.commonBackgroundColor
          ),
          child: Stack(
            children: <Widget>[
              new Image(
                width: MediaQuery.of(pageKey.currentContext).size.width - 40,
                image: NetworkImage(
                  item['image']
                ),
                fit: BoxFit.fill
              ),
              Container(
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
            ]
          )
        );
      }).toList(),
      autoPlay: true,
      autoPlayCurve: Curves.fastOutSlowIn
    );
  }

  getNews () async {
    try {
      await widget.getLatestNews(pageNews);
      return true;
    } catch (err) {
      return false;
    }
  }

  getAllNews () async {
    try {
      await getHots();
      await getNews();
    } catch (err) {
    }
    Future.delayed(const Duration(milliseconds: 1000), () async {
      setState(() {
        loading = false;
      });
    });
  }

  getHots () async {
    try {
      List<dynamic> hots = await widget.getHotNews(pageHot);
      carouselInstance = buildCarousel(hots);
      return true;
    } catch (err) {
      return false;
    }
  }

  getMoreNews () async {
    try {
      await widget.getMoreLatestNews(pageNews);
    } catch (err) {
    }
    setState(() {
      onLoadMoreNews = false;
    });
  }

  getMoreHots () async {
    try {
      await widget.getMoreHotNews(pageHot);
    } catch (err) {
    }
    setState(() {
      onLoadMoreHot = false;
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
          new NewsCarouselAnimated(animation: animation, instance: carouselInstance),
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
                      controller: tabbarControllder,
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
                      controller: tabControllder,
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
                              return new NewsList(
                                list: news ?? [],
                                widget: widget,
                                controller: scrollController,
                                features: { 'download': true, 'share': true }
                              );
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
                              return new NewsList(
                                list: news ?? [],
                                widget: widget,
                                controller: scrollController,
                                features: { 'download': true, 'share': true }
                              );
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