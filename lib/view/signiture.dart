import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:sqlproject/controller/signatureContro.dart';

class SignaturePage extends StatefulWidget {
  SignaturePage({super.key});

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  final SignatureCtrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signature Pad"),
      ),
      body: Column(children: [
        Obx(() => Flexible(
              // height: 600,
              child: Signature(
                controller: SignatureCtrl.signatureController,
                backgroundColor: SignatureCtrl.padColor.value,
              ),
            )),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  onPressed: () {
                    setState(() {
                      SignatureCtrl.selectPadColor();
                    });
                  },
                  child: const Text(
                    "Pad Color",
                    style: TextStyle(color: Colors.white),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () {
                    setState(() {
                      SignatureCtrl.selectPenColor();
                    });
                  },
                  child: const Text(
                    "Pen Color",
                    style: TextStyle(color: Colors.black),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  onPressed: () {
                    setState(() {
                      SignatureCtrl.exportSignature();
                    });
                  },
                  child: const Text(
                    "Export",
                    style: TextStyle(color: Colors.white),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {
                    setState(() {
                      SignatureCtrl.signatureController.clear();
                    });
                  },
                  child: const Text(
                    "Clear",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        )
      ]),
    );
  }
}
