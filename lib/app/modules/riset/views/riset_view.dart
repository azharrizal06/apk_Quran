import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:login2/app/routes/app_pages.dart';

import '../controllers/riset_controller.dart';

class RisetView extends GetView<RisetController> {
  @override
  final Emailc = TextEditingController(text: "azharrizal06@gmail.com");
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RisetView'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.offNamed(Routes.LOGIN),
            icon: Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: Emailc,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.mail_outline,
                  size: 30,
                ),
                label: Text("Email"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  animationDuration: Duration(milliseconds: 200),
                  backgroundColor: Colors.indigo,
                  elevation: 20,
                  shadowColor: Colors.black,
                  minimumSize: Size(400, 10),
                  padding: EdgeInsetsDirectional.symmetric(
                      vertical: 5, horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              onPressed: () => controller.riset(
                    Emailc.text,
                  ),
              child: Text("Masuk", style: TextStyle(fontSize: 24))),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
