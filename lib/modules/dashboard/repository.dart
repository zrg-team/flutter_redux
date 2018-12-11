import 'package:http/http.dart' as http;
import 'package:cat_dog/common/configs.dart';

Future<String> fetchHotNews() async {
  const url = GET_NEWS_API;
  var response = await http.get(url);
  // print("Response status: ${response.statusCode}");
  // print("Response body: ${response.body}");
  return response.body;
}

Future<String> fetchLatestNews() async {
  const url = GET_NEWS_API + '/tin-moi.epi';
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