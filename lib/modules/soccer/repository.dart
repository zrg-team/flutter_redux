import 'package:http/http.dart' as http;
import 'package:cat_dog/common/configs.dart';

Future<String> fetchSoccerCalendar() async {
  String url = GET_NEWS_API + "/soccer/m";
  var response = await http.get(url);
  return response.body;
}