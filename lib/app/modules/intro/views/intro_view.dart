import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../routes/app_pages.dart';
import '../controllers/intro_controller.dart';

class IntroView extends GetView<IntroController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IntroductionScreen(
      pages: [
        PageViewModel(
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            title: "Myapp",
            body:
                "kami akan memperkenalkan beberapa fitur penting dalam aplikasi kami dan cara menggunakan aplikasi dengan efektif. Jadi, pastikan Anda membaca setiap halaman secara seksama!",
            image: LottieBuilder.asset("assets/lottie/intro1.json")),
        PageViewModel(
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            title: "MyApp",
            body:
                "Terima kasih telah memilih kami. Mari mulai dan rasakan manfaatnya!",
            image: LottieBuilder.asset("assets/lottie/intro2.json")),
        PageViewModel(
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            title: "Myapp",
            body:
                "aplikasi ini memudahkan anda dalam berkomunikasi tanpa ada batasan waktu dan jarak",
            image: LottieBuilder.asset("assets/lottie/intro3.json"))
      ],
      showNextButton: false,
      done: const Text("Done"),
      onDone: () {
        Get.offNamed(Routes.LOGIN);
      },
    ));
  }
}
