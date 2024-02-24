import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PathProviderGpa{

  Future<void> veriYaz(String avg) async {
    var ad = await getApplicationDocumentsDirectory();

    var yol = await ad.path;

    var dosya = File("$yol/gpa.txt");

    dosya.writeAsString(avg);
  }

  Future<String> veriOku() async {
    var ad = await getApplicationDocumentsDirectory();

    var yol = await ad.path;

    var dosya = File("$yol/gpa.txt");

    String okunanVeri = await dosya.readAsString();

    return okunanVeri;
  }
}