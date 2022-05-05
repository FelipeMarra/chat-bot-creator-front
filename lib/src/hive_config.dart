import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig {
  static start() async {
    //Directory dir = await getApplicationDocumentsDirectory();
    Hive.initFlutter();
  }
}
