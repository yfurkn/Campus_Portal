import 'package:campus_portal_project/database/dao/todo_dao.dart';
import 'package:flutter/material.dart';

import '../../database/todo.dart';
import '../home_page.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {

  Future<List<ToDo>> allToDo() async {
    var todoList = await ToDoDao().tumToDo();
    return todoList;
  }

  Future<void> todoSil(int todo_id) async{
    await ToDoDao().todoSil(todo_id);
    setState(() {
    });
  }

  Future<void> todoEkle(String todo_name, int todo_isdone) async {
    await ToDoDao().todoEkle(todo_name, todo_isdone);
    setState(() {
    });
  }

  Future<void> toggleGuncelle(int todo_id, int todo_isdone) async {
    await ToDoDao().toggleGuncelle(todo_id, todo_isdone);
  }

  Future<void> todoGuncelle(int todo_id, String todo_name) async {
    await ToDoDao().todoGuncelle(todo_id, todo_name);
  }

  void toggleTask(int index,int todo_id, int todo_isdone){
    int newIsDone = todo_isdone == 1 ? 0 : 1;
    toggleGuncelle(todo_id, newIsDone);
    setState(() {
    });
  }

  void showAddTaskDialog(BuildContext context) {
    TextEditingController taskController = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
            content: TextField(
              controller: taskController,
              autofocus: true,
              decoration: const InputDecoration(
                  hintText: "Mission.."
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    taskController.text = "";
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")
              ),
              TextButton(
                  onPressed: () {
                    todoEkle(taskController.text, 0);
                    taskController.text = "";
                    Navigator.pop(context);
                  },
                  child: const Text("Add")
              ),
            ],
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey.shade300,
          leading: IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
            },
            icon: const Icon(Icons.chevron_left, size: 45, color: Colors.black),
          ),
          title: const Text("ToDo App",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),


        body: FutureBuilder<List<ToDo>> (
          future: allToDo(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              var todoList = snapshot.data;
              return ListView.builder(
                itemCount: todoList?.length,
                itemBuilder: (context, index){
                  var todo = todoList?[index];
                  return GestureDetector(
                    onTap: (){

                    },
                    child: Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(todo!.todo_name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          const Spacer(),
                          Checkbox(
                              value: todo!.todo_isdone == 1 ? true : false,
                              activeColor: Colors.green,
                              onChanged: (bool? value){
                                toggleTask(index, todo!.todo_id, todo!.todo_isdone);
                              }
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red,),
                            onPressed: (){
                              todoSil(todo.todo_id);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            else{
              return Center();
            }
          },
        ),



        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showAddTaskDialog(context);
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add, size: 40, color: Colors.white),
        ),

      ),
    );
  }
}
