import 'dart:async';
import 'package:app/services/service.dart';
import 'dart:convert';

class LoginService {
  static LoginService _loginService;

  static LoginService getInstance(){
    if(_loginService == null){
      _loginService = new LoginService();
    }
    return _loginService;
  }

  Future<bool> login(Map<String, dynamic> requestBody) async {
/*    final response = await Service.getInstance().post(requestBody, "/commerce/auth/login");
    if (response == false) {
      return response;
    }
    Map<String, dynamic> responseBody = json.decode(response.body);
    if (responseBody["token"] != null) {
      Service.getInstance().authToken = responseBody["token"];
      return true;
    }
    return false;*/
    return true;
  }
}
