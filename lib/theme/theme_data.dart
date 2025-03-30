import 'package:flutter/material.dart';
import '../constants.dart';

const AppBarTheme appBarLightTheme = AppBarTheme(
  backgroundColor: Colors.white,
  elevation: 0,
  iconTheme: IconThemeData(color: Colors.black),
  titleTextStyle: TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  ),
);

const AppBarTheme appBarDarkTheme = AppBarTheme(
  backgroundColor: Colors.black,
  elevation: 0,
  iconTheme: IconThemeData(color: Colors.white),
  titleTextStyle: TextStyle(
    fontSize: 70,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  ),
);

ScrollbarThemeData scrollbarThemeData = ScrollbarThemeData(
  trackColor: MaterialStateProperty.all(primaryColor),
);

DataTableThemeData dataTableLightThemeData = DataTableThemeData(
  columnSpacing: 24,
  headingRowColor: MaterialStateProperty.all(Colors.black12),
  decoration: BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(defaultBorderRadious)),
    border: Border.all(color: Colors.black12),
  ),
  dataTextStyle: const TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  ),
);

DataTableThemeData dataTableDarkThemeData = DataTableThemeData(
  columnSpacing: 24,
  headingRowColor: MaterialStateProperty.all(Colors.white10),
  decoration: BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(defaultBorderRadious)),
    border: Border.all(color: Colors.white10),
  ),
  dataTextStyle: const TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.white,
    fontSize: 50,
  ),
);
