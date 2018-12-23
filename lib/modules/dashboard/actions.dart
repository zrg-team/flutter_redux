import 'package:html/parser.dart' show parse;
import 'package:redux/redux.dart';
import 'package:cat_dog/common/state.dart';
import 'package:cat_dog/modules/dashboard/repository.dart';

class SetHotNews {
  final List<Object> news;
  SetHotNews(this.news);
}

class SetLatestNews {
  final List<Object> news;
  SetLatestNews(this.news);
}

class AppendHotNews {
  final List<Object> news;
  AppendHotNews(this.news);
}

class AppendLatestNews {
  final List<Object> news;
  AppendLatestNews(this.news);
}

// FIXME: Convert html to markdown :v
final Function getDetailNews = (String url) async {
  try {
    String result = await fetchDetailNews(url);
    List<Object> video = [];
    List<Object> list = [];
    if (result != '') {
      var document = parse(result);
      var breadcrumbs = document.getElementsByClassName('breadcrumbs')[0];
      var element = document.getElementsByClassName('article')[0];
      var body = document.getElementsByClassName('article__body')[0];
      var meta = element.getElementsByClassName('article__meta')[0];
      element.getElementsByClassName('article__meta')[0].remove();
      element.getElementsByClassName('article__action')[0].remove();
      // DEV: header and meta
      var breadcrumbText = '';
      breadcrumbs.getElementsByClassName('cate').forEach((tag) {
        breadcrumbText += tag.innerHtml + ' / ';
      });
      breadcrumbText = breadcrumbText.substring(0, breadcrumbText.length - 2); 
      // DEV: header and meta
      var texts = """
**${element.getElementsByClassName('article__header')[0].innerHtml.trim()}**
=======

$breadcrumbText

`${meta.getElementsByTagName('time')[0].innerHtml.trim()} - ${meta.getElementsByClassName('source')[0].innerHtml.trim()}`
""";
      // DEV: summary
      texts += """

---

**${element.getElementsByClassName('article__sapo')[0].innerHtml.trim()}**

---

""";
      // DEV: news body
      body.getElementsByTagName('p').forEach((tag) {
        if (tag.className.contains('body-author')) {
          texts += """
---

${tag.innerHtml.trim()}

""";
        } else if (tag.className.contains('image-caption')) {
          texts += """
**${tag.getElementsByTagName('em')[0].innerHtml.trim()}**
""";
        } else if (tag.className.contains('body-text')) {
          texts += """

${tag.innerHtml.trim()}

""";
        } else if (tag.className.contains('body-image')) {
          var image = tag.getElementsByTagName('img')[0];
          texts += """

![Image](${image.attributes['src']})

""";
        } else if (tag.className.contains('body-video')) {
          var videoTag = tag.getElementsByTagName('video')[0];
          video.add({
            'url': videoTag.getElementsByTagName('source')[0].attributes['data-src'],
            'image': videoTag.attributes['poster']
          });
        }
      });
      try {
        list = parseNews(result)['data'];
      } catch (error) {
      }
      // DEV: remove html tag
      return {
        'video': video,
        'text': texts
          .replaceAll('<strong>', '')
          .replaceAll('</strong>', '')
          .replaceAll('<em>', '')
          .replaceAll('</em>', '')
          .replaceAll('<br>', ''),
        'related': list
      };
    }
   } catch (err) {
    print(err);
  }
  return {
    'video': [],
    'relate': [],
    'text': 'No Content Here'
  };
};

final Function parseNews = (result) {
  try {
    List<Object> data = new List();
    List<Object> hots = new List();
    var document = parse(result);
    var elements = document
      .getElementsByTagName('body')[0]
      .getElementsByClassName('story');
    int i;
    int length = elements.length;
    for (i = 0; i < length; i++) {
      try {
        var element = elements[i];
        var tagLink = element.getElementsByClassName('story__link')[0];
        var tagHeading = element.getElementsByClassName('story__heading')[0];
        var tagSummary = element.getElementsByClassName('story__summary')[0];
        var tagImage = element.getElementsByTagName('img')[0];
        var tagMeta = element.getElementsByClassName('story__meta')[0];
        var item = {
          'url': tagLink.attributes['href'],
          'heading': tagHeading.innerHtml,
          'summary': tagSummary.innerHtml,
          'source': tagMeta.getElementsByClassName('source')[0].innerHtml,
          'time': tagMeta.getElementsByTagName('time')[0].attributes['datetime'],
          'image': tagImage.attributes['data-src']
        };
        data.add(item);
        if (hots.length < 7) {
          hots.add(item);
        }
      } catch (err) {
      }
    }
    if (data.length > 0) {
      return {
        'hot': hots,
        'data': data
      };
    }
  } catch (err) {
  }
  return {
    'hot': [],
    'data': []
  };
};

final Function getHotNewsAction = (Store<AppState> store, int page) async {
  String result = await fetchHotNews(page);
  if (result != '') {
    var data = parseNews(result);
    store.dispatch(new SetHotNews(data['data']));
    return data['hot'];
  }
  return [];
};

final Function getLatestNewsAction = (Store<AppState> store, int page) async {
  String result = await fetchLatestNews(page);
  if (result != '') {
    var data = parseNews(result);
    store.dispatch(new SetLatestNews(data['data']));
    return data;
  }
  return [];
};

final Function getMoreHotNewsAction = (Store<AppState> store, int page) async {
  String result = await fetchHotNews(page);
  if (result != '') {
    var data = parseNews(result);
    store.dispatch(new AppendHotNews(data['data']));
  }
};

final Function getMoreLatestNewsAction = (Store<AppState> store, int page) async {
  String result = await fetchLatestNews(page);
  if (result != '') {
    var data = parseNews(result);
    store.dispatch(new AppendLatestNews(data['data']));
  }
};