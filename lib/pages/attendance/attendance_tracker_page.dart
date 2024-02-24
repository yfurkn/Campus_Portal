import 'package:flutter/material.dart';

import '../../database/attendance.dart';
import '../../database/dao/attendance_dao.dart';
import '../home_page.dart';
import 'attendance_add_page.dart';

class AttendanceTrackerPage extends StatefulWidget {
  const AttendanceTrackerPage({Key? key}) : super(key: key);

  @override
  State<AttendanceTrackerPage> createState() => _AttendanceTrackerPageState();
}

class _AttendanceTrackerPageState extends State<AttendanceTrackerPage> {

  Future<List<Attendance>> allAttendance() async {
    var list = await AttendanceDao().allAttendance();
    return list;
  }

  Future<void> deleteAttendance(int id) async{
    await AttendanceDao().deleteAttendance(id);
    setState(() {});
  }

  Future<void> updateAttendance(int id, String name, String times, String abs) async{
    await AttendanceDao().updateAttendance(id, name, times, abs);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
          title: const Text("Attendance Tracker",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),


        body: FutureBuilder<List<Attendance>>(
          future: allAttendance(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              var attList = snapshot.data;
              return ListView.builder(
                itemCount: attList!.length,
                itemBuilder: (context, index) {
                  var list = attList[index];
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                      child: Container(
                        height: size.height*0.12,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black87,
                                offset: Offset(5, 5),
                                blurRadius: 10
                            ),
                          ],
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(list.name, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),

                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                border: Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: (){
                                      int abs = int.parse(list.abs);
                                      abs = abs-1;
                                      updateAttendance(list.id, list.name, list.times, abs.toString());
                                    },
                                    icon: const Icon(Icons.remove_circle_outline, color: Colors.red,),
                                  ),
                                  Text(list.abs, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                                  IconButton(
                                    onPressed: (){
                                      int abs = int.parse(list.abs);
                                      abs = abs+1;
                                      updateAttendance(list.id, list.name, list.times, abs.toString());
                                    },
                                    icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                                  ),
                                ],
                              ),
                            ),

                            CircularProgressIndicator(
                              value: double.parse(list.abs) / (double.parse(list.times) * 14),
                              backgroundColor: Colors.grey,
                              valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                            ),

                            IconButton(
                              onPressed: (){
                                deleteAttendance(list.id);
                              },
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            else if(snapshot.hasError){
              return Center(child: Text("${snapshot.error}"));
            }
            else{
              return const Center(child: Text("LOADING.."));
            }
          },
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AttendanceAddPage()));
            },
          ),
        ),

      ),
    );
  }
}
