import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_api_proj/model/headlines_model.dart';

class ApiService {
  Future<Map<String, dynamic>> getMethod(String url) async {
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    var headLines = HeadLinesModel.fromJson(jsonData);
    if (headLines.status == "ok") {
      return {'status': 200, 'body': headLines};
    } else if (response.statusCode == 404) {
      return {'status': response.statusCode, 'body': "Something went Wrong"};
    } else {
      return {'status': 503, 'body': "Error"};
    }
  }
}
