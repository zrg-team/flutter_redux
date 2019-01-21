import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cat_dog/common/utils/navigation.dart';

class CategoriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StaggeredGridView.count(
      primary: false,
      crossAxisCount: 4,
      mainAxisSpacing: 0.0,
      crossAxisSpacing: 0.0,
      children: <Widget>[
        new _Tile(
          'assets/images/tinhot.png',
          10,
          'Tin Nóng',
          '',
          'https://m.baomoi.com'
        ),
        new _Tile(
          'assets/images/latest.jpg',
          11,
          'Tin Mới',
          '',
          'https://m.baomoi.com/tin-moi.epi'
        ),
        new _Tile(
          'assets/images/xahoi.jpg',
          1,
          'Xã Hội',
          '',
          'https://m.baomoi.com/xa-hoi.epi'
        ),
        new _Tile(
          'assets/images/thegioi.jpg',
          2,
          'Thế Giới',
          '',
          'https://m.baomoi.com/the-gioi.epi'
        ),
        new _Tile(
          'assets/images/vanhoa.jpg',
          3,
          'Văn Hóa',
          '',
          'https://m.baomoi.com/van-hoa.epi'
        ),
        new _Tile(
          'assets/images/kinhte.jpg',
          4,
          'Kinh Tế',
          '',
          'https://m.baomoi.com/kinh-te.epi'
        ),
        new _Tile(
          'assets/images/giaitri.jpg',
          5,
          'Giải Trí',
          '',
          'https://m.baomoi.com/giai-tri.epi'
        ),
        new _Tile(
          'assets/images/thethao.jpg',
          6,
          'Thể Thao',
          '',
          'https://m.baomoi.com/the-thao.epi'
        ),
        new _Tile(
          'assets/images/congnghe.jpg',
          7,
          'Công Nghệ',
          '',
          'https://m.baomoi.com/khoa-hoc-cong-nghe.epi'
        ),
        new _Tile(
          'assets/images/giaoduc.jpg',
          8,
          'Giáo Dục',
          '',
          'https://m.baomoi.com/giao-duc.epi'
        ),
        new _Tile(
          'assets/images/khoahoc.jpg',
          9,
          'Khoa Học',
          '',
          'https://m.baomoi.com/khoa-hoc.epi'
        ),
        new _Tile(
          'assets/images/lamdep.jpg',
          10,
          'Làm Đẹp',
          '',
          'https://m.baomoi.com/dinh-duong-lam-dep.epi'
        ),
        new _Tile(
          'assets/images/kinhdoanh.jpg',
          11,
          'Kinh Doanh',
          '',
          'https://m.baomoi.com/kinh-doanh.epi'
        ),
        new _Tile(
          'assets/images/honnhan.jpg',
          12,
          'Hôn Nhân',
          '',
          'https://m.baomoi.com/tinh-yeu-hon-nhan.epi'
        )
      ],
      staggeredTiles: const <StaggeredTile>[
        const StaggeredTile.fit(4),
        const StaggeredTile.fit(2),
        const StaggeredTile.fit(2),
        const StaggeredTile.fit(2),
        const StaggeredTile.fit(2),
        const StaggeredTile.fit(2),
        const StaggeredTile.fit(2),
        const StaggeredTile.fit(2),
        const StaggeredTile.fit(2),
        const StaggeredTile.fit(2),
        const StaggeredTile.fit(2),
        const StaggeredTile.fit(2),
        const StaggeredTile.fit(2),
        const StaggeredTile.fit(2)
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile(this.source, this.index, this.title, this.summary, this.url);

  final String source;
  final int index;
  final String title;
  final String summary;
  final String url;

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new FlatButton(
        onPressed: () {
          pushByName('/subview', context, { 'view': {
            'url': url,
            'title': title
          } });
        },
        child: new Column(
          children: <Widget>[
            new Image.asset(source),
            new Padding(
              padding: const EdgeInsets.all(4.0),
              child: new Column(
                children: <Widget>[
                  new Text(
                    this.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  new Text(
                    summary,
                    style: const TextStyle(color: Colors.grey),
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}