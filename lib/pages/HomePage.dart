import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:cat_dog/modules/dashboard/containers/NewsTab.dart';
import 'package:cat_dog/common/components/MainDrawer.dart';
import 'package:cat_dog/common/components/GradientAppBar.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  State<HomePage> createState() => new _HomePageState();
}
class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _mainKey = new GlobalKey<ScaffoldState>();

  Function hideCallback;

  // Function refreshCallback;
  // AnimationController animationController;
  // Animation<double> animation;
  // Future timeout;
  // var timeoutSteam;

  @override
  void initState() {
    super.initState();
    // animationController = AnimationController(
    //     duration: const Duration(milliseconds: 2000), vsync: this);
    // animation = CurvedAnimation(parent: animationController, curve: Curves.easeIn);

    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     animationController.repeat();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _mainKey,
      appBar: new PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: new GradientAppBar(
          'Trang Chủ',
          Icon(
            Icons.dehaze,
            size: 32
          ),
          () => _mainKey.currentState.openDrawer(),
          Icon(
            Icons.chrome_reader_mode,
            size: 32
          ),
          () {
            if (hideCallback != null) {
              hideCallback();
            }
          }
          // new AnimatedIcon(animation: animation),
          // () async {
          //   if (animationController.isAnimating) {
          //     return false;
          //   }
          //   if (timeout != null && timeoutSteam != null) {
          //     timeoutSteam.cancel();
          //     timeout = null;
          //     timeoutSteam = null;
          //   }
          //   animationController.forward();
          //   if (refreshCallback != null) {
          //     refreshCallback();
          //   }
          //   timeout = Future.delayed(const Duration(milliseconds: 4000));
          //   timeoutSteam = timeout.asStream().listen((_) {
          //     animationController.stop();
          //     timeout = null;
          //     timeoutSteam = null;
          //   });
          // }
        ),
      ),
      body: Builder(
        builder: (context) => new NewsTab(
          // refreshCallback: (input) {
          //   refreshCallback = input;
          // },
          hideCallback: (input) {
            hideCallback = input;
          },
          scaffoldContext: context
        )
      ),
      drawer: new MainDrawer(),
    );
  }
}

class AnimatedIcon extends AnimatedWidget {
  // The Tweens are static because they don't change.
  static final _sizeTween = Tween<double>(begin: 0, end: math.pi * 50);

  AnimatedIcon({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    final Matrix4 transform = new Matrix4.rotationZ(_sizeTween.evaluate(animation) * 0.1);
    return Center(
      child: Transform(
        transform: transform,
        alignment: FractionalOffset.center,
        child: new Icon(
          Icons.refresh,
          size: 32,
        )
      )
    );
  }
}