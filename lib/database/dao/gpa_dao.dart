import '../database_helper.dart';
import '../gpa.dart';

class GpaDao{

  // ALL GPA
  Future<List<Gpa>> allGpa() async {
    var db = await DatabaseHelper.databaseAccess();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM gpa");

    return List.generate(maps.length, (i){
      var satir = maps[i];

      return Gpa(satir["gpa_id"], satir["gpa_name"], satir["gpa_credit"], satir["gpa_average"]);
    });
  }

  // ADD GPA
  Future<void> addGpa(String gpa_name, String gpa_credit, String gpa_average) async {
    var db = await DatabaseHelper.databaseAccess();

    var bilgiler = Map<String, dynamic>();
    bilgiler["gpa_name"] = gpa_name;
    bilgiler["gpa_credit"] = gpa_credit;
    bilgiler["gpa_average"] = gpa_average;

    await db.insert("gpa", bilgiler);
  }

  // UPDATE GPA
  Future<void> updateGpa(int gpa_id, String gpa_name, String gpa_credit, String gpa_average) async {
    var db = await DatabaseHelper.databaseAccess();

    var bilgiler = Map<String, dynamic>();
    bilgiler["gpa_name"] = gpa_name;
    bilgiler["gpa_credit"] = gpa_credit;
    bilgiler["gpa_average"] = gpa_average;

    await db.update("gpa", bilgiler, where: "gpa_id = ?", whereArgs: [gpa_id]);
  }

  // DELETE GPA
  Future<void> deleteGpa(int gpa_id) async {
    var db = await DatabaseHelper.databaseAccess();

    await db.delete("gpa", where: "gpa_id = ?", whereArgs: [gpa_id]);
  }

  // CALCULATE GPA
  Future<double> calculateAvg() async{
    var db = await DatabaseHelper.databaseAccess();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT round(sum(gpa_credit*gpa_average)/sum(gpa_credit),2) as average FROM gpa");

    if (maps.isNotEmpty && maps[0]['average'] != null) {
      double average = maps[0]['average'] as double;
      return average;
    }
    else {
      return 0;
    }
  }

}