import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:login2/app/data/model/bookmark.dart';
import 'package:login2/app/data/model/detailjuz.dart';
import 'package:login2/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import '../../../data/model/surat.dart';

class HomeController extends GetxController {
  Databasemanager database = Databasemanager.instance;
  Future<Map<String, dynamic>?> addlast() async {
    Database db = await database.db;
    List<Map<String, dynamic>?> last =
        await db.query("bookmark", where: 'last_read = 1');
    if (last.length == 0) {
      return null;
    } else {
      return last.first;
    }
  }

  hapus(int id) async {
    Database db = await database.db;
    await db.delete("bookmark", where: "id == ${id}");
    update();

    Get.snackbar("berhasil", "berhasil menghaspus");
  }

  Future<List<Map<String, dynamic>>> getbookmark() async {
    Database db = await database.db;
    List<Map<String, dynamic>> alldata =
        await db.query("bookmark", where: 'last_read=0');
    return alldata;
  }

  RxBool isDark = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> keluar() async {
    await auth.signOut();
    Get.offNamed(Routes.LOGIN);
    print("berhasil keluar");
  }

  List<Surat> allayat = [];

  Future<List<Surat>> ambils() async {
    var api = await http.get(Uri.parse("https://api.quran.gading.dev/surah"));
    // print(api.body);
    List? data = (jsonDecode(api.body) as Map<String, dynamic>)['data'];
    // Surat sural = Surat.fromJson(data[113]);
    // print(sural);
    if (data == null) {
      return [];
    } else {
      data.forEach((e) => allayat.add(Surat.fromJson(e)));

      return allayat;
    }
  }

  Future<List<Juz>> dtljuz() async {
    List<Juz> result = [];
    for (var i = 1; i < 30; i++) {
      var res =
          await http.get(Uri.parse("https://api.quran.gading.dev/juz/${i}"));
      Map<String, dynamic> data =
          (jsonDecode(res.body) as Map<String, dynamic>)['data'];
      Juz juz = Juz.fromJson(data);
      result.add(juz);
    }

    return result;
  }
}
