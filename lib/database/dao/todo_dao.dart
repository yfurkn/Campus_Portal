import '../database_helper.dart';
import '../todo.dart';

class ToDoDao{


  // Tüm yapılacaklar listesini listelemek için
  Future<List<ToDo>> tumToDo() async {
    var db = await DatabaseHelper.databaseAccess();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM todo");

    return List.generate(maps.length, (i){
      var satir = maps[i];

      return ToDo(satir["todo_id"], satir["todo_name"], satir["todo_isdone"]);

    });
  }


  // Yapılacaklar listesine yenisini eklemek için
  Future<void> todoEkle(String todo_name, int todo_isdone) async {
    var db = await DatabaseHelper.databaseAccess();

    var bilgiler = Map<String, dynamic>();
    bilgiler["todo_name"] = todo_name;
    bilgiler["todo_isdone"] = todo_isdone;

    await db.insert("todo", bilgiler);
  }


  // Yapılacaklar listesindeki birini güncellemek için
  Future<void> todoGuncelle(int todo_id, String todo_name) async {
    var db = await DatabaseHelper.databaseAccess();

    var bilgiler = Map<String, dynamic>();
    bilgiler["todo_name"] = todo_name;

    await db.update("todo", bilgiler, where: "todo_id = ?", whereArgs: [todo_id]);
  }

  Future<void> toggleGuncelle(int todo_id, int todo_isdone) async {
    var db = await DatabaseHelper.databaseAccess();

    var bilgiler = Map<String, dynamic>();
    bilgiler["todo_isdone"] = todo_isdone;

    await db.update("todo", bilgiler, where: "todo_id = ?", whereArgs: [todo_id]);
  }


  // Yapılacaklar listesindeki birini silmek için
  Future<void> todoSil(int todo_id) async {
    var db = await DatabaseHelper.databaseAccess();

    await db.delete("todo", where: "todo_id = ?", whereArgs: [todo_id]);
  }

}