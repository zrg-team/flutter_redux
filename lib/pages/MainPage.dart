import 'package:flutter/material.dart';
import 'package:cat_dog/presentation/platform_adaptive.dart';
import 'package:cat_dog/styles/texts.dart';
import 'package:cat_dog/modules/dashboard/components/DiscoverComponent.dart';
import 'package:cat_dog/modules/category/components/CategoriesView.dart';
import 'package:cat_dog/modules/dashboard/containers/NewsTab.dart';
import 'package:cat_dog/common/components/MainDrawer.dart';
import 'package:cat_dog/common/components/GradientAppBar.dart';
import 'package:cat_dog/common/components/BottomBar.dart';


class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);
  @override
  State<MainPage> createState() => new MainScreenState();
}
class MainScreenState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _mainKey = new GlobalKey<ScaffoldState>();
  PageController _tabController;
  String _title;
  int _index;

  @override
  void initState() {
    super.initState();
    _tabController = new PageController();
    _title = TabItems[0].title;
    _index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _mainKey,
      appBar: new PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: new GradientAppBar(
          _title,
          Icon(
            Icons.dehaze,
            size: 32
          ),
          () => _mainKey.currentState.openDrawer(),
          null,
          () {
            _tabController.jumpToPage(0);
          }
        ),
      ),
      bottomNavigationBar: 
      new PlatformAdaptiveBottomBar(
        currentIndex: _index,
        onTap: onTap,
        items: TabItems.map((TabItem item) {
          return new BottomNavigationBarItem(
            title: new Text(
              item.title,
              style: textStyles['bottom_label'],
            ),
            icon: new Icon(
              item.icon,
              size: 25
            ),
          );
        }).toList(),
      ),
      body: new PageView(
        controller: _tabController,
        onPageChanged: onTabChanged,
        children: <Widget>[
          new NewsTab(),
          new CategoriesView(),
          new DiscoverComponent()
        ],
      ),
      drawer: new MainDrawer(),
    );
  }

  void onTap(int tab){
    _tabController.jumpToPage(tab);
  }

  void onTabChanged(int tab) {
    setState((){
      this._index = tab;
    });
    this._title = TabItems[tab].title;
  }
}
