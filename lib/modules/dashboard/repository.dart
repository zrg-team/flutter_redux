import 'package:http/http.dart' as http;
import 'package:cat_dog/common/configs.dart';

Future<String> fetchHotNews(int page) async {
  String url = GET_NEWS_API + "/trang$page.epi?loadmore=1";
  var response = await http.get(url);
  // print("Response status: ${response.statusCode}");
  // print("Response body: ${response.body}");
  return response.body;
}

Future<String> fetchLatestNews(int page) async {
  String url = GET_NEWS_API + "/tin-moi/trang$page.epi?loadmore=1";
  var response = await http.get(url);
  // print("Response status: ${response.statusCode}");
  // print("Response body: ${response.body}");
  return response.body;
}

Future<String> fetchDetailNews(item) async {
  String url = GET_NEWS_API + item;
  var response = await http.get(url);
  // print("Response status: ${response.statusCode}");
  // print("Response body: ${response.body}");
  return response.body;
}