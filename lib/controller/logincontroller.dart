import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sqlproject/view/dbhomepage.dart';
import 'package:sqlproject/network/apimanager.dart';

class LoginController extends GetxController {
  List<TextEditingController> ctrl = [
    for (int i = 0; i < 10; i++) TextEditingController()
  ];

  login() async {
    Map _map = {
      "action": "login",
      "email": ctrl[0].text.trim(),
      "password": ctrl[1].text.trim(),
    };

    await ApiManager().getLogin(_map).then((value) {
      if (value.status == 1) {
        Get.to(const HomePage());
      }
    });
  }
}
