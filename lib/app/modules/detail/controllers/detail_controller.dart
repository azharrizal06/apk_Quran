import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart ' as http;
import 'package:just_audio/just_audio.dart';
import 'package:login2/app/data/model/bookmark.dart';
import 'package:login2/app/data/model/detailsurat.dart';
// import 'package:login2/app/data/model/surat.dart';
import 'package:sqflite/sqflite.dart';

class DetailController extends GetxController {
  Databasemanager database = Databasemanager.instance;
  Future<void> addbookmark(
      bool lastread, Detailsurat surat, Verse ayat, int indexayat) async {
    Database db = await database.db;
    bool flag = false;
    if (lastread == true) {
      await db.delete("bookmark", where: "last_read = 1");
    } else {
      List<Map<String, dynamic>> cekdata = await db.query('bookmark',
          where:
              " surah = '${surat.name!.transliteration!.id!.replaceAll("'", "#")}' and ayat= ${ayat.number!.inSurah} and juz= ${ayat.meta!.juz} and via= 'surah' and index_ayat= ${indexayat} and last_read=0");
      if (cekdata.length != 0) {
        flag = true;
      }
    }
    if (flag == false) {
      await db.insert("bookmark", {
        "surah": "${surat.name!.transliteration!.id!.replaceAll("'", "#")}",
        "ayat": ayat.number!.inSurah,
        "juz": ayat.meta!.juz,
        "via": 'surah',
        "index_ayat": indexayat,
        "last_read": lastread == true ? 1 : 0,
      });
      Get.back();
      Get.snackbar("berhasil", "berhasil di simpan");
    } else {
      Get.back();
      Get.snackbar("Gagal di simpan", "telah tersimpan");
    }
    var data = await db.query("bookmark");
    print(data);
  }

  RxBool isDark = false.obs;
  final player = AudioPlayer();
  Future<Detailsurat> getdetail(Id) async {
    var respon =
        await http.get(Uri.parse('https://api.quran.gading.dev/surah/${Id}'));
    var dtl = (jsonDecode(respon.body) as Map<String, dynamic>)['data'];

    return Detailsurat.fromJson(dtl);
  }

  void berhenti(Verse? ayat) async {
    ayat?.kondisi = "stop";
    await player.stop();
    update();
  }

  void lanjut(Verse? ayat) async {
    ayat?.kondisi = 'play';
    update();
    await player.play();
    update();
    ayat?.kondisi = "stop";
    await player.stop();
  }

  void puse(Verse? ayat) async {
    await player.pause();
    ayat?.kondisi = 'puse';
    update();
  }

  Verse? terahir;
  void playaudio(Verse? ayat) async {
    if (ayat?.audio?.primary != null) {
      if (terahir == null) {
        terahir = ayat;
      }
      terahir?.kondisi = "stop";
      terahir = ayat;
      terahir?.kondisi = "stop";
      update();
      await player.stop();
      await player.setUrl(ayat?.audio?.primary ?? "");
      update();
      ayat?.kondisi = "play";
      await player.play();
      update();
      ayat?.kondisi = "stop";
      await player.stop();
      update();
    } else {
      Get.defaultDialog(title: "error");
    }
  }

  @override
  void onClose() {
    player.pause();
    super.onClose();
  }
}
