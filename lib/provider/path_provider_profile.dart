import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PathProviderProfile{

  Future<void> saveName(String name) async {
    var ad = await getApplicationDocumentsDirectory();

    var yol = await ad.path;

    var dosya = File("$yol/name.txt");

    dosya.writeAsString(name);
  }


  Future<String> readName() async {
    var ad = await getApplicationDocumentsDirectory();

    var yol = await ad.path;

    var dosya = File("$yol/name.txt");

    String okunanVeri = await dosya.readAsString();

    return okunanVeri;

  }

  ///////////////////////////////////////////////////////////////////////////////
  Future<void> saveMail(String name) async {
    var ad = await getApplicationDocumentsDirectory();

    var yol = await ad.path;

    var dosya = File("$yol/mail.txt");

    dosya.writeAsString(name);
  }


  Future<String> readMail() async {
    var ad = await getApplicationDocumentsDirectory();

    var yol = await ad.path;

    var dosya = File("$yol/mail.txt");

    String okunanVeri = await dosya.readAsString();

    return okunanVeri;
  }

  ///////////////////////////////////////////////////////////////////////////////
  Future<void> saveId(String name) async {
    var ad = await getApplicationDocumentsDirectory();

    var yol = await ad.path;

    var dosya = File("$yol/id.txt");

    dosya.writeAsString(name);
  }


  Future<String> readId() async {
    var ad = await getApplicationDocumentsDirectory();

    var yol = await ad.path;

    var dosya = File("$yol/id.txt");

    String okunanVeri = await dosya.readAsString();

    return okunanVeri;
  }

  ///////////////////////////////////////////////////////////////////////////////
  Future<void> saveSchool(String name) async {
    var ad = await getApplicationDocumentsDirectory();

    var yol = await ad.path;

    var dosya = File("$yol/sch.txt");

    dosya.writeAsString(name);
  }


  Future<String> readSchool() async {
    var ad = await getApplicationDocumentsDirectory();

    var yol = await ad.path;

    var dosya = File("$yol/sch.txt");

    String okunanVeri = await dosya.readAsString();

    return okunanVeri;
  }

  ///////////////////////////////////////////////////////////////////////////////
  Future<void> saveDepartment(String name) async {
    var ad = await getApplicationDocumentsDirectory();

    var yol = await ad.path;

    var dosya = File("$yol/dep.txt");

    dosya.writeAsString(name);
  }


  Future<String> readDepartment() async {
    var ad = await getApplicationDocumentsDirectory();

    var yol = await ad.path;

    var dosya = File("$yol/dep.txt");

    String okunanVeri = await dosya.readAsString();

    return okunanVeri;
  }

}