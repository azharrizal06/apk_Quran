import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login2/app/data/model/detailsurat.dart';
import 'package:login2/app/data/model/surat.dart';

void main() async {
  var api = await http.get(Uri.parse("https://api.quran.gading.dev/surah"));
  // print(api.body);
  List data = (jsonDecode(api.body) as Map<String, dynamic>)['data'];
  Surat sural = Surat.fromJson(data[113]);
  // print(sural.name);
  var apidetail = await http
      .get(Uri.parse("https://api.quran.gading.dev/surah/${sural.number}"));
  var suratdtl = (jsonDecode(apidetail.body) as Map<String, dynamic>)['data'];
  Detailsurat suratd = Detailsurat.fromJson(suratdtl);
  print(suratd.verses![0].text!.arab);
}
