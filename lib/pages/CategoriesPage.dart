import 'package:flutter/material.dart';
import 'package:cat_dog/common/utils/navigation.dart';
import 'package:cat_dog/modules/category/components/CategoriesView.dart';
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
        child: new GradientAppBar(
          'Thể Loại',
          Icon(
            Icons.arrow_back,
            size: 32
          ),
          () {
            navigationPop(context);
          },
          null,
          () async {
          }
        )
      ),
      body: new CategoriesView()
    );
  }
}