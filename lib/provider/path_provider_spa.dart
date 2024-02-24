import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PathProviderSpa{

  Future<void> veriYaz(String avg) async {
    var ad = await getApplicationDocumentsDirectory();

    var yol = await ad.path;

    var dosya = File("$yol/spa.txt");

    dosya.writeAsString(avg);
  }

  Future<String> veriOku() async {
    var ad = await getApplicationDocumentsDirectory();

    var yol = await ad.path;

    var dosya = File("$yol/spa.txt");

    String okunanVeri = await dosya.readAsString();

    return okunanVeri;
  }
}