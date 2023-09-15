import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:login2/app/data/model/surat.dart';
import 'package:lottie/lottie.dart';

import '../../../data/model/detailjuz.dart' as dtl;
import '../../../warna/warana.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/detailjuz_controller.dart';

class DetailjuzView extends GetView<DetailjuzController> {
  final dtl.Juz datajuz = Get.arguments['juz'];
  final List<Surat> namaayat = Get.arguments['ayat'];
  final homec = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    namaayat.forEach((element) {
      print(element.name?.transliteration?.id);
    });
    // var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text('Juz ${datajuz.juz}'),
              Text(' (${datajuz.totalVerses} ayat)'),
            ],
          ),
          centerTitle: true,
          actions: [
            Obx(
              () => IconButton(
                onPressed: () {
                  Get.isDarkMode
                      ? Get.changeTheme(terang)
                      : Get.changeTheme(gelap);
                },
                icon: Icon(
                  controller.isDark.isTrue
                      ? Icons.nightlight
                      : Icons.light_mode,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: FutureBuilder<dtl.Juz>(
              future: controller.dtljuz(datajuz.juz),
              builder: (context, Snapshot) {
                if (Snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Container(
                      width: lebar,
                      // height: tinggi,
                      child: LottieBuilder.asset(
                        "assets/lottie/loading.json",
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: Snapshot.data?.totalVerses,
                  itemBuilder: (context, index) {
                    dtl.Verses? datajuz = Snapshot.data?.verses![index];
                    var ayat = namaayat[controller.no];
                    if (index != 0) {
                      if (datajuz?.number?.inSurah == 1) {
                        controller.no++;
                      }
                    }
                    // var tes = Snapshot.data?.verses?[index].kondisi;

                    print('ini tes${datajuz?.kondisi}');
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/gambar/border.png",
                                      width: 40,
                                    ),
                                    Text(
                                      '${datajuz!.number?.inSurah}',
                                      style: TextStyle(color: hitam),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${ayat.name?.transliteration?.id ?? 'null'}',
                                  style: TextStyle(color: putih),
                                ),
                                GetBuilder<DetailjuzController>(
                                  builder: (c) => Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Get.defaultDialog(
                                              title: "Bookmark",
                                              middleText: "tandai sebagai ",
                                              actions: [
                                                TextButton(
                                                    onPressed: () async {
                                                      await c.addbookmark(
                                                          true,
                                                          ayat
                                                              .name
                                                              ?.transliteration!
                                                              .id,
                                                          datajuz
                                                              .number?.inSurah,
                                                          index);
                                                      homec.update();
                                                    },
                                                    child: Text(
                                                        'terahir di baca')),
                                                TextButton(
                                                    onPressed: () {
                                                      c.addbookmark(
                                                        false,
                                                        ayat
                                                            .name
                                                            ?.transliteration!
                                                            .id,
                                                        datajuz.number?.inSurah,
                                                        index,
                                                      );
                                                    },
                                                    child: Text('simpan'))
                                              ]);
                                        },
                                        icon: Icon(
                                          Icons.bookmarks,
                                        ),
                                      ),
                                      (datajuz.kondisi == "stop")
                                          ? IconButton(
                                              onPressed: () {
                                                c.playaudio(datajuz);
                                              },
                                              icon: Icon(
                                                  Icons.play_circle_outline),
                                            )
                                          : Row(
                                              children: [
                                                (datajuz.kondisi == "play")
                                                    ? IconButton(
                                                        onPressed: () {
                                                          c.puse(datajuz);
                                                        },
                                                        icon: Icon(Icons.pause),
                                                      )
                                                    : IconButton(
                                                        onPressed: () {
                                                          c.lanjut(datajuz);
                                                        },
                                                        icon: Icon(Icons
                                                            .play_circle_outline),
                                                      ),
                                                IconButton(
                                                  onPressed: () {
                                                    c.berhenti(datajuz);
                                                  },
                                                  icon: Icon(Icons.stop),
                                                )
                                              ],
                                            )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Text(
                          "${datajuz.text?.arab}",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${datajuz.text?.transliteration?.en}",
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("${datajuz.translation?.id}",
                            textAlign: TextAlign.justify)
                      ],
                    );
                  },
                );
              }),
        ));
  }
}
