import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:cat_dog/pages/LoadingPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cat_dog/common/components/NewsList.dart';
import 'package:cat_dog/common/components/MiniNewsList.dart';
import 'package:cat_dog/common/utils/navigation.dart';
import 'package:cat_dog/common/components/ImageCached.dart';

const int TAB_LATEST = 0;
const int TAB_HOT = 1;
const int TAB_VIDEO = 2;
const int TAB_TOPIC = 3;

class NewsTabView extends StatefulWidget {
  final Function saveNews;
  final Function getHotNews;
  final Function getLatestNews;
  final Function getTopicNews;
  final Function getVideoNews;
  final Function hideCallback;
  final Function getMoreHotNews;
  final Function getMoreLatestNews;
  final Function getMoreTopicNews;
  final Function getMoreVideoNews;
  final Function checkFirstOpen;
  final BuildContext scaffoldContext;
  final bool shouldLoading;
  const NewsTabView({
    Key key,
    this.saveNews,
    this.hideCallback,
    this.getHotNews,
    this.getLatestNews,
    this.scaffoldContext,
    this.getMoreHotNews,
    this.getMoreLatestNews,
    this.getTopicNews,
    this.getVideoNews,
    this.getMoreTopicNews,
    this.getMoreVideoNews,
    this.checkFirstOpen,
    dynamic shouldLoading,
  }) :
  shouldLoading = shouldLoading == null ? true : shouldLoading,
  super(key: key);

  @override
  _NewsTabViewState createState() => new _NewsTabViewState();
}

class _NewsTabViewState extends State<NewsTabView> with TickerProviderStateMixin {
  int tabIndex = TAB_LATEST;
  bool loading = true;

  int pageHot = 1;
  int pageNews = 1;
  int pageVideo = 1;
  int pageTopic = 1;
  bool onLoadMoreHot = false;
  bool onLoadMoreNews = false;
  bool onLoadMoreVideo = false;
  bool onLoadMoreTopic = false;

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

    loading = widget.shouldLoading;
  
    getAllNews();
    widget.checkFirstOpen();

    // Animation
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    animation = CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);
    widget.hideCallback(() async {
      if (!animationController.isAnimating &&
        !animationController.isCompleted &&
        carouselInstance != null) {
        animationController.forward();
      } else if (!animationController.isAnimating && animationController.isCompleted) {
        animationController.reverse();
      }
    });
    // Tab Events
    tabControllder = new TabController(length: 4, vsync: this);
    tabbarControllder = new TabController(length: 4, vsync: this);
    tabbarControllder.addListener(() {
      tabControllder.animateTo(tabbarControllder.index);
    });
    tabControllder.addListener(() {
      tabbarControllder.animateTo(tabControllder.index);
      tabIndex = tabControllder.index;
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

  void handleRefresh(dynamic refreshController, bool isUp) async {
    try {
      if (isUp) {
        await getAllNews();
        scrollController.animateTo(
          0,
          duration: new Duration(milliseconds: 400),
          curve: Curves.easeInOut
        );
      } else {
        if (tabIndex == TAB_HOT && !onLoadMoreHot) {
          pageHot += 1;
          onLoadMoreHot = true;
          await getMoreHots();
        } else if (tabIndex == TAB_LATEST && !onLoadMoreNews) {
          pageNews += 1;
          onLoadMoreNews = true;
          await getMoreNews();
        } else if (tabIndex == TAB_VIDEO && !onLoadMoreVideo) {
          pageVideo += 1;
          onLoadMoreVideo = true;
          await getMoreVideos();
        } else if (tabIndex == TAB_TOPIC && !onLoadMoreTopic) {
          pageTopic += 1;
          onLoadMoreTopic = true;
          await getMoreTopics();
        }
      }
      Future.delayed(Duration(milliseconds: 3000), () {
        refreshController.sendBack(isUp, 3); // Status completed
      });
    } catch (err) {
      Future.delayed(Duration(milliseconds: 3000), () {
        refreshController.sendBack(isUp, 4); // Status fail
      });
    }
  }

  getAllNews () async {
    try {
      getHots();
      await getNews();
      getVideos();
      getTopics();
    } catch (err) {
    }
    Future.delayed(const Duration(milliseconds: 300), () async {
      setState(() {
        loading = false;
      });
    });
  }

  getNews () async {
    try {
      await widget.getLatestNews(pageNews);
      return true;
    } catch (err) {
      return false;
    }
  }

  getHots () async {
    try {
      List<dynamic> hots = await widget.getHotNews(pageHot);
      Future.delayed(Duration(milliseconds: 300), () {
        carouselInstance = buildCarousel(hots);
        animationController.forward();
      });
      return true;
    } catch (err) {
      return false;
    }
  }

  getVideos () async {
    try {
      await widget.getVideoNews(pageNews);
      return true;
    } catch (err) {
      return false;
    }
  }

  getTopics () async {
    try {
      await widget.getTopicNews(pageNews);
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

  getMoreVideos () async {
    try {
      await widget.getMoreVideoNews(pageVideo);
    } catch (err) {
    }
    setState(() {
      onLoadMoreVideo = false;
    });
  }

  getMoreTopics () async {
    try {
      await widget.getMoreTopicNews(pageTopic);
    } catch (err) {
    }
    setState(() {
      onLoadMoreTopic = false;
    });
  }

  CarouselSlider buildCarousel (List<dynamic> hots) {
    return CarouselSlider(
      items: hots.map((item) {
        return new Container(
          margin: EdgeInsets.only(left: 4.0, right: 4.0, top: 1.0),
          width: MediaQuery.of(pageKey.currentContext).size.width - 40,
          height: 190.0,
          decoration: new BoxDecoration(
            color: AppColors.commonBackgroundColor
          ),
          child: Stack(
            children: <Widget>[
              ImageCached(
                url: item['image'],
                width: MediaQuery.of(pageKey.currentContext).size.width - 40.0,
                height: 190.0
              ),
              Container(
                alignment: Alignment(-0.9, 0.75),
                child: new FlatButton(
                  child: Text(
                    item['heading'],
                    textAlign: TextAlign.start,
                    style: new TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0
                    )
                  ),
                  onPressed: () {
                    pushByName('/reading', context, { 'news': item });
                  }
                )
              )
            ]
          )
        );
      }).toList(),
      height: 190.0,
      autoPlay: true,
      autoPlayCurve: Curves.fastOutSlowIn
    );
  }

  Widget buildListNews(BuildContext context, Function getData) {
    return new Container(
      decoration: new BoxDecoration(
        color: AppColors.commonBackgroundColor
      ),
      child: new StoreConnector<AppState, dynamic>(
        converter: (Store<AppState> store) {
          return getData(store);
        },
        builder: (BuildContext context, news) {
          return NewsList(
            list: news ?? [],
            widget: widget,
            controller: scrollController,
            handleRefresh: handleRefresh,
            features: { 'download': true, 'share': true }
          );
        }
      )
    );
  }

  Widget buildListTopics(BuildContext context, Function getData) {
    return new Container(
      decoration: new BoxDecoration(
        color: AppColors.commonBackgroundColor
      ),
      child: new StoreConnector<AppState, dynamic>(
        converter: (Store<AppState> store) {
          return getData(store);
        },
        builder: (BuildContext context, news) => MiniNewsList(
          list: news ?? [],
          widget: widget,
          folding: true,
          controller: scrollController,
          handleRefresh: handleRefresh,
          onTap: (seleted) {
            pushByName('/reading', context, { 'news': seleted });
          },
        )
      )
    );
  }

  Widget buildTabBar(BuildContext context) {
    return new Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      // margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.white
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            child: Icon(Icons.list, color: AppColors.specicalBackgroundColor)
          ),
          Expanded(
            child: TabBar(
              isScrollable: true,
              controller: tabbarControllder,
              indicatorColor: AppColors.specicalBackgroundColor,
              labelColor: AppColors.specicalBackgroundColor,
              unselectedLabelColor: AppColors.gray,
              tabs: [
                Tab(
                  // icon: Icon(Icons.home)
                  text: 'Tin Mới'
                ),
                Tab(
                  text: 'Tin Nóng'
                ),
                Tab(
                  text: 'Videos'
                ),
                Tab(
                  text: 'Chủ Đề'
                )
              ]
            )
          )
        ],
      )
    );
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
              length: 4,
              child: new Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  buildTabBar(context),
                  new Expanded(
                    child: TabBarView(
                      controller: tabControllder,
                      children: [
                        buildListNews(context, (Store<AppState> store) {
                          return store.state.dashboard.news;
                        }),
                        buildListNews(context, (Store<AppState> store) {
                          return store.state.dashboard.hot;
                        }),
                        buildListNews(context, (Store<AppState> store) {
                          return store.state.dashboard.videos;
                        }),
                        buildListTopics(context, (Store<AppState> store) {
                          return store.state.dashboard.topicNews;
                        })
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
  static final _sizeTween = Tween<double>(begin: 0.0, end: 180.0);
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