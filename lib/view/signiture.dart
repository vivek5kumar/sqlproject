import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:sqlproject/controller/signatureContro.dart';

class SignaturePage extends StatefulWidget {
  const SignaturePage({super.key});

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  // ignore: non_constant_identifier_names
  final SignatureCtrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signature Pad"),
        centerTitle: true,
      ),
      body: Column(children: [
        Obx(() => Flexible(
              // height: 600,
              child: Signature(
                controller: SignatureCtrl.signatureController,
                backgroundColor: SignatureCtrl.padColor.value,
              ),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
        )
      ]),
    );
  }
}
