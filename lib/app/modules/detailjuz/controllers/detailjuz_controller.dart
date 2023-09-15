import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:login2/app/data/model/detailjuz.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/model/bookmark.dart';

class DetailjuzController extends GetxController {
  Databasemanager database = Databasemanager.instance;
  Future<void> addbookmark(bool lastread, surat, ayat, int indexayat) async {
    Database db = await database.db;
    bool flag = false;
    if (lastread == true) {
      await db.delete("bookmark", where: "last_read = 1");
    } else {
      List cekdata = await db.query('bookmark',
          where:
              " surah = '${surat.toString().replaceAll("'", "#")}' and ayat= ${ayat} and juz= ${ayat} and via = 'juz' and index_ayat= ${indexayat} and last_read=0");
      if (cekdata.length != 0) {
        flag = true;
      }
    
    }
    if (flag == false) {
      var cekk = await db.insert("bookmark", {
        "surah": "${surat.toString().replaceAll("'", "#")}",
        "ayat": ayat,
        "juz": ayat,
        "via": 'juz',
        "index_ayat": indexayat,
        "last_read": lastread == true ? 1 : 0,
      });
      print(cekk);Get.back();
      Get.snackbar("berhasil", "berhasil di simpan");
      
    } else {Get.back();
      Get.snackbar("Gagal di simpan", "telah tersimpan");
      
    }
    await db.query("bookmark");
  }

  int no = 0;
  RxBool isDark = false.obs;

  Future<Juz> dtljuz(id) async {
    var res =
        await http.get(Uri.parse("https://api.quran.gading.dev/juz/${id}"));
    var data = (jsonDecode(res.body) as Map<String, dynamic>)["data"];
    var datajuz = Juz.fromJson(data);

    return datajuz;
  }

  final player = AudioPlayer();
  void berhenti(Verses? datajuz) async {
    datajuz?.kondisi = "stop";
    await player.stop();
    update();
  }

  void lanjut(Verses? datajuz) async {
    datajuz?.kondisi = 'play';
    update();
    await player.play();
    update();
    datajuz?.kondisi = "stop";
    await player.stop();
  }

  void puse(Verses? datajuz) async {
    await player.pause();
    datajuz?.kondisi = 'puse';
    update();
  }

  Verses? terahir;
  void playaudio(Verses? datajuz) async {
    try {
      if (datajuz?.audio?.primary != null) {
        if (terahir == null) {
          terahir = datajuz;
        }
        terahir?.kondisi = "stop";
        terahir = datajuz;
        terahir?.kondisi = "stop";
        update();
        await player.stop();
        await player.setUrl(datajuz?.audio?.primary ?? "");
        update();
        datajuz?.kondisi = "play";
        await player.play();
        update();
        datajuz?.kondisi = "stop";
        await player.stop();
        update();
      } else {
        Get.defaultDialog(title: "error");
      }
    } catch (e) {}
  }

  @override
  void onClose() {
    player.pause();
    super.onClose();
  }
}
