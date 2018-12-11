import 'package:http/http.dart' as http;

Future<String> fetchNewsFromUrl(url) async {
  var response = await http.get(url);
  return response.body;
}