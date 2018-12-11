import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:cat_dog/modules/user/actions.dart';
import 'package:cat_dog/common/state.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, dynamic>(
      converter: (store) => () { store.dispatch(logoutAction()); },
      builder: (BuildContext context, logout) => new Container(
        decoration: BoxDecoration(
          color: AppColors.commonBackgroundColor
        ),
        child: new Drawer(
          child: new ListView(
            children: <Widget>[
            new Container(
              height: 120.0,
              child: new DrawerHeader(
                padding: new EdgeInsets.all(0.0),
                // decoration: new BoxDecoration(
                //   color: AppColors.itemDefaultColor
                // ),
                child: new Center(
                  child: new ClipRect(
                    child: new BackdropFilter(
                      filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: new Container(
                        decoration: new BoxDecoration(
                          color: Colors.grey.shade200.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(0)
                        ),
                        child: new Center(
                          child: new FlutterLogo(
                          colors: AppColors.primary,
                          size: 54.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ),
            ),
            new ListTile(
              leading: new Icon(Icons.home),
              title: new Text('Trang Chủ'),
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
              }
            ),
            new ListTile(
              leading: new Icon(Icons.apps),
              title: new Text('Thế Loại'),
              onTap: () {
                Navigator.of(context).pushNamed('/categories');
              }
            ),
            new ListTile(
              leading: new Icon(Icons.save),
              title: new Text('Tin Đã Lưu'),
              onTap: () {
                Navigator.of(context).pushNamed('/saved');
              }
            ),
            new ListTile(
              leading: new Icon(Icons.school),
              title: new Text('Nguồn Tin'),
              onTap: () {
                Navigator.of(context).pushNamed('/source');
              }
            ),
            new ListTile(
              leading: new Icon(Icons.chat),
              title: new Text('Hướng Dẫn'),
              onTap: () => print('you pressed support')
            ),
            new ListTile(
              leading: new Icon(Icons.info),
              title: new Text('Thông Tin'),
              onTap: () => print('you pressed about')
            ),
            new Divider(),
            new ListTile(
              leading: new Icon(Icons.exit_to_app),
              title: new Text('Đăng Xuất'),
              onTap: () {
                logout(context);
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
              }
            ),
            ],
          )
        ),
      )
    );
  }
}