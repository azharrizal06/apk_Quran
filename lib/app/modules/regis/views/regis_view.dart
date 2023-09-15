import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/regis_controller.dart';

class RegisView extends GetView<RegisController> {
  @override
  final Email = TextEditingController();
  final password = TextEditingController();
  Widget build(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Column(
                  children: [
                    Container(
                      height: tinggi * 0.26,
                      width: lebar * 0.6,
                      child: LottieBuilder.asset(
                        "assets/lottie/daftar.json",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(height: 15),
                    TextField(
                      controller: Email,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail_outline,
                            size: 30,
                          ),
                          label: Text("Email"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_open,
                            size: 30,
                          ),
                          label: Text("Password"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    SizedBox(height: 15),
                    SizedBox(height: 15),
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
                        onPressed: () =>
                            controller.daftar(Email.text, password.text),
                        child: Text("Daftar", style: TextStyle(fontSize: 24))),
                    SizedBox(
                      height: 25,
                    ),
                    Text("Atau daftar menggunakan"),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(

                          // alignment: Alignment.centerLeft,
                          foregroundColor: Color(0xffE74C3C),
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  color: Color(0xffE74C3C), width: 3))),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("assets/gambar/google.png"),
                          Text(
                            "Google",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xffE74C3C), fontSize: 24),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          // alignment: Alignment.centerLeft,
                          foregroundColor: Color(0xff3498DB),
                          backgroundColor: Colors.white,
                          minimumSize: Size(400, 20),
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  color: Color(0xff3498DB), width: 3))),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("assets/gambar/fb.png"),
                          Text(
                            "Facebook",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff3498DB), fontSize: 24),
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: Row(
                        children: [
                          Text("sudah punya akun?"),
                          Text(" Silakan"),
                          TextButton(
                              onPressed: () => Get.toNamed(Routes.LOGIN),
                              child: Text(
                                "Masuk",
                                style: TextStyle(color: Color(0xff3498DB)),
                              )),
                        ],
                      ),
                    )
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
