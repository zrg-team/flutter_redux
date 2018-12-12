import 'package:http/http.dart' as http;
import 'package:cat_dog/common/configs.dart';

Future<String> fetchAboutInformation() async {
  const url = ABOUT_URL;
  var response = await http.get(url);
  // print("Response status: ${response.statusCode}");
  // print("Response body: ${response.body}");
  return response.body;
}