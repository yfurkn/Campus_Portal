import '../database_helper.dart';
import '../spa.dart';

class SpaDao{

  // ALL SPA
  Future<List<Spa>> allSpa() async {
    var db = await DatabaseHelper.databaseAccess();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM spa");

    return List.generate(maps.length, (i){
      var satir = maps[i];

      return Spa(satir["spa_id"], satir["spa_name"], satir["spa_credit"], satir["spa_grade"]);
    });
  }

  // ADD SPA
  Future<void> addSpa(String spa_name, String spa_credit, String spa_grade) async {
    var db = await DatabaseHelper.databaseAccess();

    var bilgiler = Map<String, dynamic>();
    bilgiler["spa_name"] = spa_name;
    bilgiler["spa_credit"] = spa_credit;
    bilgiler["spa_grade"] = spa_grade;

    await db.insert("spa", bilgiler);
  }

  // UPDATE SPA
  Future<void> updateSpa(int spa_id, String spa_name, String spa_credit, String spa_grade) async {
    var db = await DatabaseHelper.databaseAccess();

    var bilgiler = Map<String, dynamic>();
    bilgiler["spa_name"] = spa_name;
    bilgiler["spa_credit"] = spa_credit;
    bilgiler["spa_grade"] = spa_grade;

    await db.update("spa", bilgiler, where: "spa_id = ?", whereArgs: [spa_id]);
  }

  // DELETE SPA
  Future<void> deleteSpa(int spa_id) async {
    var db = await DatabaseHelper.databaseAccess();

    await db.delete("spa", where: "spa_id = ?", whereArgs: [spa_id]);
  }

  // CALCULATE SPA
  Future<double> calculateAverage() async{
    var db = await DatabaseHelper.databaseAccess();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT round(sum(spa_credit*spa_grade)/sum(spa_credit),2) as average FROM spa");

    if (maps.isNotEmpty && maps[0]['average'] != null) {
      double average = maps[0]['average'] as double;
      return average;
    }
    else {
      return 0;
    }
  }

  Future<int> sumCredit() async {
    var db = await DatabaseHelper.databaseAccess();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT sum(spa_credit) as sum_credit FROM spa");

    if (maps.isNotEmpty && maps[0]['sum_credit'] != null) {
      int average = maps[0]['sum_credit'] as int;
      return average;
    }
    else {
      return 0;
    }
  }


}