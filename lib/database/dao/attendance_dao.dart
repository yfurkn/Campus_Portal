import 'package:campus_portal_project/database/database_helper.dart';

import '../attendance.dart';

class AttendanceDao{

  // ALL
  Future<List<Attendance>> allAttendance() async {
    var db = await DatabaseHelper.databaseAccess();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM attendance");

    return List.generate(maps.length, (i) {
      var satir = maps[i];

      return Attendance(satir["id"], satir["name"], satir["times"], satir["abs"]);
    });
  }

  // ADD
  Future<void> addAttendance(String name, String times, String abs) async{
    var db = await DatabaseHelper.databaseAccess();

    var data = <String, dynamic>{};
    data["name"] = name;
    data["times"] = times;
    data["abs"] = abs;

    await db.insert("attendance", data);
  }

  // UPDATE
  Future<void> updateAttendance(int id, String name, String times, String abs) async{
    var db = await DatabaseHelper.databaseAccess();

    var data = <String, dynamic>{};
    data["name"] = name;
    data["times"] = times;
    data["abs"] = abs;

    await db.update("attendance", data, where: "id = ?", whereArgs: [id]);
  }

  // DELETE
  Future<void> deleteAttendance(int id) async{
    var db = await DatabaseHelper.databaseAccess();

    await db.delete("attendance", where: "id = ?", whereArgs: [id]);
  }




}