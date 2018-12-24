import 'dart:async';
import 'package:cat_dog/common/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:cat_dog/modules/welcome/animations/page_dragger.dart';
import 'package:cat_dog/modules/welcome/animations/page_reveal.dart';
import 'package:cat_dog/modules/welcome/components/PagerIndicatorView.dart';
import 'package:cat_dog/modules/welcome/components/PagerView.dart';

class BoardingPage extends StatefulWidget {
  @override
  _BoardingPageState createState() => new _BoardingPageState();
}
class _BoardingPageState extends State<BoardingPage> with TickerProviderStateMixin {

   StreamController<SlideUpdate> slideUpdateStream;
   AnimatedPageDragger animatedPageDragger;

   int activeIndex = 0 ;
   SlideDirection slideDirection = SlideDirection.none;
   int nextPageIndex = 0 ;
   double slidePercent= 0.0;

  _BoardingPageState(){
    slideUpdateStream = new StreamController<SlideUpdate>();

    slideUpdateStream.stream.listen((SlideUpdate event){
      setState(() {
        if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = activeIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft){
            nextPageIndex = activeIndex + 1;
          } else {
            nextPageIndex = activeIndex;
          }
        } else if (event.updateType == UpdateType.doneDragging) {
          if (slidePercent > 0.5) {
            animatedPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.open,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );

          } else {
            animatedPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.close,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
            nextPageIndex = activeIndex;
          }

          animatedPageDragger.run();
        } else if (event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        } else if (event.updateType == UpdateType.doneAnimating) {
          activeIndex = nextPageIndex;
          slideDirection = SlideDirection.none;
          slidePercent = 0.0;
          animatedPageDragger.dispose();
        }
        if (activeIndex == 2) {
          Future.delayed(Duration(milliseconds: 1000), () {
            pushAndRemoveByName('/home', context, {});
          });
        }
      });
    });


}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: [
          new PagerView(
            viewModel: pages[activeIndex],
            percentVisible: 1.0 ,
          ),
          new PageReveal(
            revealPercent: slidePercent,
            child: new PagerView(
              viewModel: pages[nextPageIndex],
              percentVisible: slidePercent ,
            ),
          ),
          new PagerIndicatorView(
            viewModel: new PagerIndicatorViewModel(
              pages,
              activeIndex,
              slideDirection,
              slidePercent,
            )
          ),
          new PageDragger(
            canDragLeftToRight: activeIndex > 0 ,
            canDragRightToLeft: activeIndex < pages.length - 1 ,
            slideUpdateStream: this.slideUpdateStream,
          )
        ],
      ),
    );
  }
}