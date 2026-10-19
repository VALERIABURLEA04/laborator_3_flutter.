
import 'dart:convert';
import 'package:flutter/services.dart';

class JsonLoader {
  static Future<Map<String, dynamic>> loadStoreData() async {
    final String jsonString =
    await rootBundle.loadString('assets/data/gemstore.json');
    final Map<String, dynamic> jsonData =
    jsonDecode(jsonString);

    return jsonData;
  }
}
