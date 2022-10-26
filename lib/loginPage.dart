import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqlproject/controller/logincontroller.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final loginCtrl = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: loginCtrl.ctrl[0],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "required";
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: "username..", border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: loginCtrl.ctrl[1],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "required";
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: "password..", border: OutlineInputBorder()),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        // primary: kpurpleColor,
                        fixedSize: const Size(100, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: const Text("Login"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
