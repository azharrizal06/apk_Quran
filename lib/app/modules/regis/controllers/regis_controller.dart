import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/app_pages.dart';

class RegisController extends GetxController {
  var auth = FirebaseAuth.instance;
  Future<void> daftar(String Emailc, String passwordc) async {
    try {
      UserCredential myuser = await auth.createUserWithEmailAndPassword(
          email: Emailc, password: passwordc);

      await myuser.user!.sendEmailVerification();
      Get.dialog(AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: LottieBuilder.asset("assets/lottie/sentemail.json"),
        title: Text(
          "varifikasi",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
              onPressed: () => Get.offNamed(Routes.LOGIN), child: Text("Oke"))
        ],
      ));
      print("berhasil");
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return Get.dialog(AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            "Tidak Berhasil Mendaftar",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            children: [
              LottieBuilder.asset("assets/lottie/gagal.json"),
              Text("Akun ini telah di gunakan atau Telah terdaftar")
            ],
          ),
          actions: [
            TextButton(onPressed: () => Get.back(), child: Text("Oke")),
          ],
        ));
        ;
      }
    } catch (e) {}
  }
}
