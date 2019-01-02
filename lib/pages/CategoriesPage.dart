import 'package:flutter/material.dart';
import 'package:cat_dog/modules/category/components/CategoriesView.dart';
import 'package:cat_dog/common/components/MainDrawer.dart';
import 'package:cat_dog/common/components/GradientAppBar.dart';


class CategoriesPage extends StatefulWidget {
  CategoriesPage({Key key}) : super(key: key);
  @override
  State<CategoriesPage> createState() => new _CategoriesPageState();
}
class _CategoriesPageState extends State<CategoriesPage> {
  final GlobalKey<ScaffoldState> _mainKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _mainKey,
      appBar: new PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: Hero(
          tag: "app-bar-hero",
          child: new GradientAppBar(
            'Thể Loại',
            Icon(
              Icons.dehaze,
              size: 32
            ),
            () => _mainKey.currentState.openDrawer(),
            null,
            () async {
            }
          )
        )
      ),
      body: new CategoriesView(),
      drawer: new MainDrawer(),
    );
  }
}