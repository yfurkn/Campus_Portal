import 'package:flutter/material.dart';

import '../../database/dao/attendance_dao.dart';
import 'attendance_tracker_page.dart';

class AttendanceAddPage extends StatefulWidget {
  const AttendanceAddPage({Key? key}) : super(key: key);

  @override
  State<AttendanceAddPage> createState() => _AttendanceAddPageState();
}

class _AttendanceAddPageState extends State<AttendanceAddPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController timesController = TextEditingController();

  Future<void> addAttendance(String name, String times, String abs) async{
    await AttendanceDao().addAttendance(name, times, abs);
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AttendanceTrackerPage()));
            },
            icon: const Icon(Icons.chevron_left, size: 45, color: Colors.black),
          ),
          title: const Text("Add Course",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),

        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: nameController,
                  autofocus: false,
                  style: const TextStyle(fontSize: 25),
                  decoration: const InputDecoration(
                      hintText: "Course Name.."
                  ),
                ),
                TextField(
                  controller: timesController,
                  autofocus: false,
                  style: const TextStyle(fontSize: 25),
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: const InputDecoration(
                      hintText: "How many times a week.."
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          width: 80,
          height: 50,
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.add_circle),
                Text("Add")
              ],
            ),
            onPressed: (){
              if(nameController.text.isNotEmpty || timesController.text.isNotEmpty){
                addAttendance(nameController.text, timesController.text, "0");
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AttendanceTrackerPage()));
              }
            },
          ),
        ),
      ),
    );
  }
}
