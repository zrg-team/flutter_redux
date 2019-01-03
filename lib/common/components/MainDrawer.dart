import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cat_dog/styles/colors.dart';
import 'package:cat_dog/modules/user/actions.dart';
import 'package:cat_dog/common/state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cat_dog/common/configs.dart';

import 'package:cat_dog/common/utils/navigation.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
      .of(context)
      .padding
      .top;
    return new StoreConnector<AppState, dynamic>(
      converter: (store) => () { store.dispatch(logoutAction()); },
      builder: (BuildContext context, logout) => Theme(
        data: Theme.of(context).copyWith(
          // Set the transparency here
          canvasColor: Colors.transparent
        ),
        child: new Drawer(
          child: Container(
            padding: new EdgeInsets.only(top: 0),
            child: new Center(
              child: new ClipRect(
                child: new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: new Container(
                    decoration: new BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.5)
                    ),
                    child: Column(
                      children: <Widget>[
                        new Container(
                          height: 120.0 + statusBarHeight,
                          child: new Container(
                            child: new ClipRect(
                              child: new BackdropFilter(
                                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                child: new Container(
                                  decoration: new BoxDecoration(
                                    color: Colors.grey.shade200.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(0)
                                  ),
                                  child: new Container(
                                    padding: EdgeInsets.only(top: statusBarHeight),
                                    child: Row(
                                      children: <Widget>[
                                        new Image(
                                          image: AssetImage('assets/store/icon.png'),
                                        ),
                                        new Text(
                                          ' EWS',
                                          style: TextStyle(
                                            fontSize: 50,
                                            color: AppColors.red,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Tusj'
                                          ),
                                        )
                                      ],
                                    )
                                  )
                                )
                              )
                            )
                          )
                        ),
                        Expanded(
                          child: new ListView(
                            children: <Widget>[
                              new ListTile(
                                leading: new Icon(Icons.home),
                                title: new Text('Trang Chủ'),
                                onTap: () {
                                  pushAndRemoveByName('/home', context, {});
                                }
                              ),
                              new Divider(),
                              new ListTile(
                                leading: new Icon(Icons.tv),
                                title: new Text('Chủ Đề Nóng'),
                                onTap: () {
                                  pushByName('/topics', context, {});
                                }
                              ),
                              new ListTile(
                                leading: new Icon(Icons.video_library),
                                title: new Text('Videos'),
                                onTap: () {
                                  pushByName('/videos', context, {});
                                }
                              ),
                              new ListTile(
                                leading: new Icon(Icons.apps),
                                title: new Text('Thế Loại'),
                                onTap: () {
                                  pushByName('/categories', context, {});
                                }
                              ),
                              new ListTile(
                                leading: new Icon(Icons.school),
                                title: new Text('Nguồn Tin'),
                                onTap: () {
                                  pushByName('/source', context, {});
                                }
                              ),
                              new ListTile(
                                leading: new Icon(Icons.save),
                                title: new Text('Tin Đã Lưu'),
                                onTap: () {
                                  pushByName('/saved', context, {});
                                }
                              ),
                              new ListTile(
                                leading: new Icon(Icons.chat),
                                title: new Text('Phản Hồi'),
                                onTap: () async {
                                  String url = FEEDBACK_URL;
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    print('Could not launch $url');
                                  }
                                }
                              ),
                              new ListTile(
                                leading: new Icon(Icons.info),
                                title: new Text('Thông Tin'),
                                onTap: () {
                                  pushByName('/about', context, {});
                                }
                              ),
                              new ListTile(
                                leading: new Icon(Icons.store_mall_directory),
                                title: new Text('Giới Thiệu'),
                                onTap: () {
                                  pushByName('/boarding', context, {});
                                }
                              )
                              // new ListTile(
                              //   leading: new Icon(Icons.exit_to_app),
                              //   title: new Text('Đăng Xuất'),
                              //   onTap: () {
                              //     logout(context);
                              //     Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
                              //   }
                              // ),
                            ],
                          )
                        )
                      ],
                    )
                  ),
                ),
              ),
            ),
          )
        )
      )
    );
  }
}