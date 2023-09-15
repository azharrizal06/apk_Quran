import 'package:flutter/material.dart';
import 'package:login2/app/data/model/detailsurat.dart' as detail;
import 'package:login2/app/warna/warana.dart';
import '../../../data/model/surat.dart';
import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/detail_controller.dart';
import 'package:lottie/lottie.dart';

class DetailView extends GetView<DetailController> {
  final Surat surat = Get.arguments;
  final homec = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('${surat.name!.transliteration!.id ?? 'error...'}'),
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
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              GestureDetector(
                onTap: () => Get.dialog(Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                        height: tinggi * 0.5,
                        child: Column(children: [
                          Column(
                            children: [
                              Text(
                                "${surat.name?.transliteration?.id}",
                                style: TextStyle(
                                    color: ungugelapb,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "${surat.tafsir?.id}",
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          )
                        ])),
                  ),
                )),
                child: Container(
                  height: tinggi * 0.25,
                  width: lebar * 0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient:
                          LinearGradient(colors: [unguterangb, unguterang])),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.auto_stories_outlined,
                                        color: putih,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      "Suroh",
                                      style:
                                          TextStyle(color: putih, fontSize: 15),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${surat.name!.transliteration!.id ?? 'error...'}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: putih,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    "${surat.numberOfVerses ?? 'error...'} Ayat ",
                                    style: TextStyle(color: putih)),
                              ],
                            ),
                            Expanded(
                              child: Container(
                                  height: tinggi * 0.3,
                                  width: lebar * 0.3,
                                  child: Image.asset(
                                    "assets/gambar/quran.png",
                                    fit: BoxFit.contain,
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder(
                  future: controller.getdetail(surat.number),
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
                      itemCount: Snapshot.data?.verses?.length ?? 0,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var banyakA = Snapshot.data?.verses?.length;
                        if (banyakA == 0) {
                          return SizedBox();
                        }
                        detail.Verse? ayat = Snapshot.data?.verses?[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/gambar/border.png",
                                          width: 40,
                                        ),
                                        Text(
                                          '${index + 1}',
                                          style: TextStyle(color: hitam),
                                        ),
                                      ],
                                    ),
                                    GetBuilder<DetailController>(
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
                                                              Snapshot.data!,
                                                              ayat!,
                                                              index);
                                                          homec.update();
                                                        },
                                                        child: Text(
                                                            'terahir di baca')),
                                                    TextButton(
                                                        onPressed: () {
                                                          c.addbookmark(
                                                              false,
                                                              Snapshot.data!,
                                                              ayat!,
                                                              index);
                                                        },
                                                        child: Text('simpan'))
                                                  ]);
                                            },
                                            icon: Icon(
                                              Icons.bookmarks,
                                            ),
                                          ),
                                          (ayat!.kondisi == "stop")
                                              ? IconButton(
                                                  onPressed: () {
                                                    c.playaudio(ayat);
                                                  },
                                                  icon: Icon(
                                                    Icons.play_circle_outline,
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    (ayat.kondisi == "play")
                                                        ? IconButton(
                                                            onPressed: () {
                                                              c.puse(ayat);
                                                            },
                                                            icon: Icon(
                                                                Icons.pause),
                                                          )
                                                        : IconButton(
                                                            onPressed: () {
                                                              c.lanjut(ayat);
                                                            },
                                                            icon: Icon(Icons
                                                                .play_circle_outline),
                                                          ),
                                                    IconButton(
                                                      onPressed: () {
                                                        c.berhenti(ayat);
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
                              "${ayat?.text?.arab}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${ayat?.text?.transliteration?.en}',
                              textAlign: TextAlign.end,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${ayat?.translation?.id}",
                              textAlign: TextAlign.justify,
                            )
                          ],
                        );
                      },
                    );
                  })
            ],
          ),
        ));
  }
}
