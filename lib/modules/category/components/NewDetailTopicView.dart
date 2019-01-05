import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:cat_dog/modules/category/actions.dart';
import 'package:cat_dog/common/utils/navigation.dart';
import 'package:cat_dog/common/configs.dart';

class NewDetailTopicView extends StatefulWidget {
  final dynamic topic;
  final BuildContext scaffoldContext;
  const NewDetailTopicView({
    Key key,
    this.topic,
    this.scaffoldContext
  }) : super(key: key);

  @override
  _NewDetailTopicViewState createState() => new _NewDetailTopicViewState();
}

class _NewDetailTopicViewState extends State<NewDetailTopicView> with TickerProviderStateMixin {
  List<Object> list = [];
  _NewDetailTopicViewState();
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    getNews(true);
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 350)
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  getNews (bool replace) async {
    await Future.delayed(Duration(milliseconds: 220), () async {
      try {
        List<dynamic> data = await getNewsFromUrl(GET_NEWS_API + widget.topic['url'], 1);
        setState(() {
          if (replace) {
            list = data;
          } else {
            list.addAll(data);
          }
        });
      } catch (err) {
        print(err);
      }
    });
  }

  Widget buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        buildInfo(),
        Expanded(
          child: buildScroller()
        )
      ],
    );
  }

  Widget buildFeatureds() {
    return PageTransformer(
      pageViewBuilder: (context, visibilityResolver) {
        return PageView.builder(
          controller: PageController(viewportFraction: 0.9),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final item = list[index];
            final pageVisibility = visibilityResolver
              .resolvePageVisibility(index);
            return GestureDetector(
              onTap: () {
                pushByName('/reading', context, { 'news': item });
              },
              child: IntroNewsItem(
                item: item, pageVisibility: pageVisibility)
            );
          },
        );
      }
    );

  }

  Widget buildAvatar() {
    return Container(
      width: 110.0,
      height: 110.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.specicalBackgroundColor),
      ),
      margin: const EdgeInsets.only(top: 10.0, left: 15.0),
      padding: const EdgeInsets.all(3.0),
      child: ClipOval(
        child: Hero(
          tag: "mini-news-feed-${widget.topic['url']}",
          child: Image.network(widget.topic['image'], fit: BoxFit.cover)
        )
      ),
    );
  }

  Widget buildInfo() {
    return Container(
      height: 125,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
          child: Row(
            children: <Widget>[
              buildAvatar(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        widget.topic['heading'],
                        style: TextStyle(
                          color: AppColors.specicalBackgroundColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      )
                    ),
                    Container(
                      color: AppColors.specicalBackgroundColor.withOpacity(0.85),
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      width: 225.0,
                      height: 1.0,
                    )
                  ],
                )
              )
            ]
          )
        )
      )
    );
  }

  Widget buildScroller() {
    return FadeTransition(
      opacity: animationController,
      child: buildFeatureds()
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height,
      color: AppColors.commonBackgroundColor,
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          color: AppColors.commonBackgroundColor,
          child: buildContent(),
        ),
      )
    );
  }
}

typedef PageView PageViewBuilder(
  BuildContext context, PageVisibilityResolver visibilityResolver);

class PageVisibilityResolver {
  PageVisibilityResolver({
    ScrollMetrics metrics,
    double viewPortFraction,
  }) : this._pageMetrics = metrics,
    this._viewPortFraction = viewPortFraction;

  final ScrollMetrics _pageMetrics;
  final double _viewPortFraction;

  PageVisibility resolvePageVisibility(int pageIndex) {
    final double pagePosition = calculatePagePosition(pageIndex);
    final double visiblePageFraction =
      calculateVisiblePageFraction(pageIndex, pagePosition);

    return new PageVisibility(
      visibleFraction: visiblePageFraction,
      pagePosition: pagePosition,
    );
  }

  double calculateVisiblePageFraction(int index, double pagePosition) {
    if (pagePosition > -1.0 && pagePosition <= 1.0) {
      return 1.0 - pagePosition.abs();
    }

    return 0.0;
  }

  double calculatePagePosition(int index) {
    final double viewPortFraction = _viewPortFraction ?? 1.0;
    final double pageViewWidth =
        (_pageMetrics?.viewportDimension ?? 1.0) * viewPortFraction;
    final double pageX = pageViewWidth * index;
    final double scrollX = (_pageMetrics?.pixels ?? 0.0);
    final double pagePosition = (pageX - scrollX) / pageViewWidth;
    final double safePagePosition = !pagePosition.isNaN ? pagePosition : 0.0;

    if (safePagePosition > 1.0) {
      return 1.0;
    } else if (safePagePosition < -1.0) {
      return -1.0;
    }

    return safePagePosition;
  }
}

class PageVisibility {
  PageVisibility({
    @required this.visibleFraction,
    @required this.pagePosition,
  });

  final double visibleFraction;

  final double pagePosition;
}

class PageTransformer extends StatefulWidget {
  PageTransformer({
    @required this.pageViewBuilder,
  });

  final PageViewBuilder pageViewBuilder;

  @override
  _PageTransformerState createState() => new _PageTransformerState();
}

class _PageTransformerState extends State<PageTransformer> {
  PageVisibilityResolver _visibilityResolver;

  @override
  Widget build(BuildContext context) {
    final pageView = widget.pageViewBuilder(
        context, _visibilityResolver ?? new PageVisibilityResolver());

    final controller = pageView.controller;
    final viewPortFraction = controller.viewportFraction;

    return new NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        setState(() {
          _visibilityResolver = new PageVisibilityResolver(
            metrics: notification.metrics,
            viewPortFraction: viewPortFraction,
          );
        });
      },
      child: pageView,
    );
  }
}

class IntroNewsItem extends StatelessWidget {
  IntroNewsItem({
    @required this.item,
    @required this.pageVisibility,
  });

  final dynamic item;
  final PageVisibility pageVisibility;

  Widget applyTextEffects({
    @required double translationFactor,
    @required Widget child,
  }) {
    final double xTranslation = pageVisibility.pagePosition * translationFactor;

    return new Opacity(
      opacity: pageVisibility.visibleFraction,
      child: new Transform(
        alignment: FractionalOffset.topLeft,
        transform: new Matrix4.translationValues(
          xTranslation,
          0.0,
          0.0,
        ),
        child: child,
      ),
    );
  }

  buildTextContainer(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final categoryText = applyTextEffects(
      translationFactor: 300.0,
      child: new Text(
        item['source'],
        style: textTheme.caption.copyWith(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
      ),
    );

    final titleText = applyTextEffects(
      translationFactor: 200.0,
      child: new Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: new Text(
          item['heading'],
          style: textTheme.title
            .copyWith(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 18.0),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return new Positioned(
      bottom: 56.0,
      left: 32.0,
      right: 32.0,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          categoryText,
          titleText,
        ],
      ),
    );
  }

  Widget getImageNetwork(url){
    return ClipRRect(
      borderRadius: new BorderRadius.circular(8.0),
      child: new FadeInImage.assetNetwork(
        placeholder: 'assets/images/noimage.jpg',
        image: url,
        fit: BoxFit.cover,
        alignment: new FractionalOffset(
          0.5 + (pageVisibility.pagePosition / 3),
          0.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 8.0,
      ),
      child: new Material(
        elevation: 4.0,
        borderRadius: new BorderRadius.circular(8.0),
        child: new Stack(
          fit: StackFit.expand,
          children: [
            new Hero(tag: item['heading'],child: getImageNetwork(item['image'])),
            getOverlayGradient(),
            buildTextContainer(context),
          ],
        ),
      ),
    );
  }

  getOverlayGradient() {
    return ClipRRect(
      borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(8.0),bottomRight: Radius.circular(8.0)),
      child: new DecoratedBox(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter,
            colors: [
              const Color(0xFF000000),
              const Color(0x00000000),
            ],
          ),
        ),
      ),
    );
  }
}