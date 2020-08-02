import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Service {
  static Service _service;

  static Service getInstance(){
    if(_service == null){
      _service = new Service();
    }
    return _service;
  }

  final String baseUrl = "your api endpoint";
  String authToken = "";

  post(Map<String, dynamic> body, String endpoint) async {
    final response = await http.post(baseUrl + endpoint,
        headers: {
          'Auth': authToken,
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      return false;
    }
  }

  get(String endpoint) async {
    var uri = baseUrl + endpoint;
    final response = await http.get(uri, headers: {
      'Auth': authToken,
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load.');
    }
  }
}
