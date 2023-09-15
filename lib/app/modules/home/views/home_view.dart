import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:login2/app/warna/warana.dart';
import 'package:lottie/lottie.dart';

import '../../../data/model/detailjuz.dart' as dtl;
import '../../../data/model/surat.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    if (Get.isDarkMode) {
      controller.isDark.value = true;
    }
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () => controller.keluar(),
            icon: Icon(
              Icons.logout,
            ),
          ),
          title: Text('Al-Quran'),
          actions: [
            Row(
              children: [
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
            )
          ],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  Text(
                    "azhar Quran",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GetBuilder<HomeController>(
                    builder: (c) {
                      return FutureBuilder<Map<String, dynamic>?>(
                          future: c.addlast(),
                          builder: (context, Snapshot) {
                            Map<String, dynamic>? last = Snapshot.data;
                            if (Snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                  height: tinggi * 0.2,
                                  // width: lebar * 0.7,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                          colors: [unguterangb, unguterang])),
                                  child: Center(child: Text("loading......")));
                            }

                            return InkWell(
                              onLongPress: () {
                                Get.defaultDialog(
                                  title: "Hapus",
                                  middleText: 'Hapus Terahir di baca?',
                                  textCancel: "Cencel",
                                  textConfirm: "oke",
                                  onConfirm: () => c.hapus(last?['id']),
                                );
                              },
                              child: Container(
                                  height: tinggi * 0.2,
                                  // width: lebar * 0.7,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                          colors: [unguterangb, unguterang])),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.auto_stories_outlined,
                                                    color: putih,
                                                    size: 30,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Terkir Dibaca",
                                                    style: TextStyle(
                                                        color: putih,
                                                        fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                              if (last != null)
                                                Text(
                                                    "${last['surah'].toString().replaceAll("#", "'")}",
                                                    style: TextStyle(
                                                        color: putih,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              Text(
                                                  last == null
                                                      ? 'Kosong'
                                                      : "ayat ${last['ayat']}",
                                                  style:
                                                      TextStyle(color: putih)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            );
                          });
                    },
                  ),
                  TabBar(
                      indicatorColor: Get.isDarkMode ? putih : unguterang,
                      labelColor: Get.isDarkMode ? putih : unguterang,
                      unselectedLabelColor: unguterangb,
                      tabs: [
                        Tab(
                          child: Text(
                            'Suroh',
                          ),
                        ),
                        Tab(
                          child: Text('Juz'),
                        ),
                        Tab(
                          child: Text('Bookmark'),
                        ),
                      ]),
                  Expanded(
                      child: TabBarView(children: [
                    FutureBuilder<List<Surat>>(
                        future: controller.ambils(),
                        builder: (context, Snapshot) {
                          if (Snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Container(
                                width: lebar,
                                height: tinggi,
                                child: LottieBuilder.asset(
                                  "assets/lottie/loading.json",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );
                          }
                          if (!Snapshot.hasData) {
                            return Text("Tidak ada data");
                          }
                          // print("tes========");
                          // print(Snapshot.data);
                          List<Surat> suratList = Snapshot.data!;
                          return ListView.builder(
                              itemCount: Snapshot.data!.length,
                              itemBuilder: (context, index) {
                                Surat surat = suratList[index];
                                return ListTile(
                                  onTap: () => Get.toNamed(Routes.DETAIL,
                                      arguments: surat),
                                  leading: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/gambar/border.png",
                                        width: 40,
                                      ),
                                      Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: ungugelap),
                                      )
                                    ],
                                  ),
                                  // Stack(child: Image.asset("assets/gambar/border.png",Text("${index + 1}"),)),
                                  title: Text(
                                    '${surat.name!.transliteration!.id ?? 'Error'}',
                                  ),
                                  subtitle: Text(
                                      "${surat.numberOfVerses ?? 'error'} ayat |  ${surat.revelation?.id ?? 'error'}"),
                                  trailing:
                                      Text("${surat.name!.short ?? 'error'}",
                                          style: TextStyle(
                                            fontSize: 20,
                                          )),
                                );
                              });
                        }),
                    FutureBuilder<List<dtl.Juz>>(
                        future: controller.dtljuz(),
                        builder: (context, Snapshot) {
                          if (Snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Container(
                                width: lebar,
                                height: tinggi,
                                child: LottieBuilder.asset(
                                  "assets/lottie/loading.json",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );
                          }
                          if (!Snapshot.hasData) {
                            return Text("Tidak ada data");
                          }

                          return ListView.builder(
                              itemCount: Snapshot.data!.length,
                              itemBuilder: (context, index) {
                                dtl.Juz datajuz = Snapshot.data![index];

                                String? namestart =
                                    datajuz.juzStartInfo?.split(" - ").first;
                                String? nameend =
                                    datajuz.juzEndInfo?.split(" - ").first;

                                List<Surat> semi = [];
                                List<Surat> fix = [];
                                for (Surat item in controller.allayat) {
                                  semi.add(item);
                                  if (item.name?.transliteration?.id ==
                                      nameend) {
                                    break;
                                  }
                                }
                                for (Surat item in semi.reversed.toList()) {
                                  fix.add(item);
                                  if (item.name?.transliteration?.id ==
                                      namestart) {
                                    break;
                                  }
                                }

                                return ListTile(
                                  onTap: () => Get.toNamed(Routes.DETAILJUZ,
                                      arguments: {
                                        'juz': datajuz,
                                        "ayat": fix.reversed.toList()
                                      }),
                                  leading: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/gambar/border.png",
                                        width: 40,
                                      ),
                                      Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: ungugelap),
                                      )
                                    ],
                                  ),
                                  // Stack(child: Image.asset("assets/gambar/border.png",Text("${index + 1}"),)),
                                  title: Text(
                                    'juz ${datajuz.juz ?? 'error'}',
                                  ),
                                  subtitle: Text(
                                      "${datajuz.juzStartInfo ?? 'error'} s/d  ${datajuz.juzEndInfo ?? 'error'}"),
                                );
                              });
                        }),
                    GetBuilder<HomeController>(
                      builder: (c) {
                        return FutureBuilder<List<Map<String, dynamic>>>(
                          future: c.getbookmark(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: Container(
                                  width: lebar,
                                  height: tinggi,
                                  child: LottieBuilder.asset(
                                    "assets/lottie/loading.json",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            }
                            if (snapshot.data!.length == 0) {
                              return Center(child: Text("Kosong"));
                            }
                            return ListView.builder(
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> data =
                                      snapshot.data![index];
                                  return ListTile(
                                    onTap: () {
                                      Get.toNamed(Routes.DETAIL,
                                          arguments: Surat);
                                    },
                                    leading: Text("${index + 1}"),
                                    title: Text(
                                        "${data['surah'].toString().replaceAll("#", "'")}"),
                                    subtitle: Row(
                                      children: [
                                        Text("ayat ${data['ayat']} "),
                                        Text("| via ${data['via']}"),
                                      ],
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        c.hapus(data['id']);
                                      },
                                      icon: Icon(
                                        Icons.delete_outline,
                                      ),
                                    ),
                                  );
                                });
                          },
                        );
                      },
                    )
                  ]))
                ],
              )),
        ));
  }
}
