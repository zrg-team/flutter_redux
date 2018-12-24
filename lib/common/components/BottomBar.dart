import 'package:flutter/material.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:cat_dog/presentation/platform_adaptive.dart';
import 'package:cat_dog/styles/texts.dart';

class BottomBar extends StatelessWidget {

  final int _index;
  final Function onTap;
  final double barHeight = 66.0;

  BottomBar(this._index, this.onTap);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
      .of(context)
      .padding
      .top;

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
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
        ),
      ),
      child: PlatformAdaptiveBottomBar(
        currentIndex: _index,
        onTap: onTap,
        items: TabItems.map((TabItem item) {
          return new BottomNavigationBarItem(
            title: new Text(
              item.title,
              style: textStyles['bottom_label'],
            ),
            icon: new Icon(item.icon),
          );
        }).toList(),
      )
    );
  }
}

class TabItem {
  final String title;
  final IconData icon;

  const TabItem({ this.title, this.icon });
}

const List<TabItem> TabItems = const <TabItem>[
  const TabItem(title: 'Hot', icon: Icons.assignment),
  const TabItem(title: 'Categories', icon: Icons.category),
  const TabItem(title: 'Discover', icon: Icons.group_work)
];