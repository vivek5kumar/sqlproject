import 'dart:convert';

import 'package:sqlproject/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:sqlproject/network/baseurl.dart';

class ApiManager {
  var response;
  Future<UserLoginResponse> getLogin(_map) async {
    var url = Uri.parse(EndPoint().userLogin);
    response = await http.post(url, body: _map);
    return UserLoginResponse.fromJson(jsonDecode(response.body.toString()));
  }
}
