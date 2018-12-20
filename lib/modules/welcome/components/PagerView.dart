import 'package:flutter/material.dart';

final pages = [
  new PageViewModel(
    const Color(0xFF548CFF),
    'assets/images/banner-1.png',
    'Tin tức phong phú',
    'Tổng hợp tin tức nóng và mới nhất từ hơn 150 báo điện tử Việt Nam.',
    Icons.near_me),
  new PageViewModel(
    const Color(0xFFE4534D),
    'assets/images/banner-2.png',
    'Chủ đề nóng',
    'Liên tục cập nhật các sự kiện nóng: U23 Việt Nam, Chiến sự syrian, ...',
    Icons.nature_people),
  new PageViewModel(
    const Color(0xFFFF682D),
    'assets/images/banner-3.png',
    'Dành cho bạn',
    'Miễn phí, đơn giản và tiện lợi !',
    Icons.devices,
  ),
];

class PagerView extends StatelessWidget {
  final PageViewModel viewModel;
  final double percentVisible;

  PagerView({
    this.viewModel,
    this.percentVisible = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: double.infinity,
        color: viewModel.color,
        child:
          new Opacity(
            opacity: percentVisible,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Transform(
                  transform: new Matrix4.translationValues(0.0, 50.0 * (1.0 - percentVisible), 0.0),
                  child: new Padding(
                      padding: new EdgeInsets.only(bottom: 25.0),
                      child:
                      new Image.asset(
                          viewModel.heroAssetPath,
                          width: 200.0,
                          height: 200.0),
                  ),
                ),
                new Transform(
                  transform: new Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible), 0.0),
                  child: new Padding(
                      padding: new EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: new Text(
                        viewModel.title,
                        style: new TextStyle(
                          color: Colors.white,
                          fontFamily: 'FlamanteRoma',
                          fontSize: 34.0,
                        ),
                      ),
                  ),
                ),
                new Transform(
                  transform: new Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible), 0.0),
                  child: new Padding(
                      padding: new EdgeInsets.only(bottom: 75.0),
                      child: new Text(
                        viewModel.body,
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                          color: Colors.white,
                          fontFamily: 'FlamanteRomaItalic',
                          fontSize: 18.0,
                        ),
                      ),
                  ),
                ),
              ]),
            ));
  }
}

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final IconData icon;

  PageViewModel(
    this.color,
    this.heroAssetPath,
    this.title,
    this.body,
    this.icon,
  );
}