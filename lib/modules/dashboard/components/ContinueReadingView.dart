import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:cat_dog/pages/LoadingPage.dart';
import 'package:cat_dog/common/utils/navigation.dart';
import 'package:cat_dog/modules/dashboard/containers/ContinueReadingDetail.dart';

const int TAB_LATEST = 0;
const int TAB_HOT = 1;
const int TAB_VIDEO = 2;
const int TAB_TOPIC = 3;

class ContinueReadingView extends StatefulWidget {
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
  const ContinueReadingView({
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
  _ContinueReadingViewState createState() => new _ContinueReadingViewState();
}

class _ContinueReadingViewState extends State<ContinueReadingView> with TickerProviderStateMixin {
  int tabIndex = TAB_LATEST;
  bool loading = true;
  List<int> newsIndex = [
    0,
    0,
    0
  ];
  List<int> newsCount = [
    0,
    0,
    0
  ];

  int pageHot = 1;
  int pageNews = 1;
  int pageVideo = 1;
  bool onLoadMoreHot = false;
  bool onLoadMoreNews = false;
  bool onLoadMoreVideo = false;

  GlobalKey pageKey = new GlobalKey();
  ScrollController scrollController = new ScrollController();
  TabController tabControllder;
  TabController tabbarControllder;

  @override
  void initState() {
    super.initState();

    loading = widget.shouldLoading;
  
    getAllNews();
    widget.checkFirstOpen();

    // Tab Events
    tabControllder = new TabController(length: 4, vsync: this);
    tabbarControllder = new TabController(length: 4, vsync: this);
    tabbarControllder.addListener(() {
      tabControllder.animateTo(tabbarControllder.index);
      setState(() {
        tabIndex = tabbarControllder.index;
      });
    });
    tabControllder.addListener(() {
      tabbarControllder.animateTo(tabControllder.index);
      setState(() {
        tabIndex = tabControllder.index;
      });
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
        Future.delayed(Duration(microseconds: 320), () async {
          await getAllNews();
          scrollController.animateTo(
            0,
            duration: new Duration(milliseconds: 400),
            curve: Curves.easeInOut
          );
        });
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
      await widget.getHotNews(pageHot);
      // Future.delayed(Duration(milliseconds: 300), () {
      //   animationController.forward();
      // });
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

  Widget buildListNews(BuildContext context, Function getData, int index) {
    if (index != tabIndex) {
      return Container();
    }
    return new Container(
      decoration: new BoxDecoration(
        color: AppColors.commonBackgroundColor
      ),
      child: new StoreConnector<AppState, dynamic>(
        converter: (Store<AppState> store) {
          return getData(store);
        },
        builder: (BuildContext context, news) {
          int id = new DateTime.now().millisecondsSinceEpoch;
          int index = newsIndex[tabIndex];
          Key newsKey = Key("continue_reading_$id");
          return ContinueReadingDetail(
            key: Key("page_continue_reading_${news[index]['url']}"),
            news: news[index],
            newsKey: newsKey,
            lastNews: index > 0 ? news[index - 1] : null,
            nextNews: index < news.length ? news[index + 1] : null,
            scaffoldContext: widget.scaffoldContext,
            onDismissed: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart && index < news.length) {
                setState(() {
                  newsIndex[tabIndex] += 1;            
                });
              } else if (direction == DismissDirection.endToStart && index == news.length) {
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
                }
              } else if (index > 0) {
                setState(() {
                  newsIndex[tabIndex] -= 1;            
                });
              } else {
                setState(() {
                  newsIndex[tabIndex] = index;            
                });
              }
            },
          );
        }
      )
    );
  }

  Widget buildTabBar(BuildContext context) {
    return new Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      // margin: EdgeInsets.only(bottom: 20),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            AppColors.appBarGradientStart,
            AppColors.appBarGradientEnd
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.5, 0.0),
          stops: [0.0, 0.5],
          tileMode: TileMode.clamp
        )
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 64,
            height: 50,
            child: FlatButton(
              child: Icon(
                Icons.arrow_back, color: AppColors.white, size: 32
              ),
              onPressed: () {
                navigationPop(widget.scaffoldContext);
              },
            )
          ),
          Expanded(
            child: TabBar(
              isScrollable: true,
              controller: tabbarControllder,
              indicatorColor: AppColors.white,
              labelColor: AppColors.white,
              unselectedLabelColor: AppColors.gray,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
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
                        }, 0),
                        buildListNews(context, (Store<AppState> store) {
                          return store.state.dashboard.hot;
                        }, 1),
                        buildListNews(context, (Store<AppState> store) {
                          return store.state.dashboard.videos;
                        }, 2)
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