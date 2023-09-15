import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import './app/warna/warana.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(myapp());
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Application",
          theme: terang,
          darkTheme: gelap,
          initialRoute: snapshot.data != null ? Routes.HOME : Routes.LOGIN,
          // initialRoute: Routes.HOME,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
