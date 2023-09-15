import 'package:flutter/material.dart';

const putih = Color(0xffFAF8FC);
const ungu = Color(0xffF431AA1);
const ungugelap = Color(0xff2E0D8A);
const unguterang = Color(0xff9345F2);
const unguterangb = Color(0xffB9A2D8);
const ungugelapb = Color(0xff260F68);
const oren = Color(0xffE6704A);
const hitam = Color(0xff010313);

ThemeData terang = ThemeData(
  cardColor: unguterangb,
  listTileTheme: ListTileThemeData(textColor: ungugelap),
  brightness: Brightness.light,
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: ungu),
    bodySmall: TextStyle(color: unguterangb),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    iconTheme: IconThemeData(color: ungugelapb),
    actionsIconTheme: IconThemeData(color: ungugelapb),
    titleTextStyle:
        TextStyle(color: ungugelapb, fontSize: 20, fontWeight: FontWeight.bold),
    backgroundColor: putih,
  ),
);
ThemeData gelap = ThemeData(
    cardColor: ungugelap,
    listTileTheme: ListTileThemeData(textColor: putih),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: hitam,
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: putih),
      bodySmall: TextStyle(color: unguterangb),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      actionsIconTheme: IconThemeData(color: putih),
      titleTextStyle:
          TextStyle(color: putih, fontSize: 20, fontWeight: FontWeight.bold),
      backgroundColor: hitam,
    ));
