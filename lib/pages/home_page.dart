import 'package:campus_portal_project/pages/todo/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utility/bottom_navigation_bar.dart';
import 'attendance/attendance_tracker_page.dart';
import 'average/average_calculator_page.dart';
import 'habit_tracker/habit_tracker_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Do you want to quit?"),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              onPressed: (){
                SystemNavigator.pop();
              },
              label: "Yes",
            ),
          ),
        );
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade300,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.grey.shade300,
            title: const Text("Home", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            actions: [
              IconButton(
                onPressed: (){
                  SystemNavigator.pop();
                },
                icon: const Icon(Icons.exit_to_app_outlined, size: 45, color: Colors.black45),
              ),
              const SizedBox(width: 15),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("About School", style: TextStyle(fontSize: 26)),

                // top boxes
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        //PathProvider().veriOku();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AverageCalculatorPage()));
                      },
                      child: Container(
                        width: 173,
                        height: 216,
                        decoration: BoxDecoration(
                          color: const Color(0xff313131),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black,
                            width: 3,
                          ),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black87,
                                offset: Offset(5, 5),
                                blurRadius: 10
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Image.asset("images/hm.png", width: 150),
                            const SizedBox(height: 10),
                            const Text("Average", style: TextStyle(fontSize: 22, color: Colors.white),),
                            const Text("Calculator", style: TextStyle(fontSize: 22, color: Colors.white60),),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AttendanceTrackerPage()));
                      },
                      child: Container(
                        width: 173,
                        height: 216,
                        decoration: BoxDecoration(
                          color: const Color(0xff313131),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black,
                            width: 3,
                          ),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black87,
                                offset: Offset(5, 5),
                                blurRadius: 10
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("images/takvim.png", width: 130),
                            const Text("Attendance", style: TextStyle(fontSize: 22, color: Colors.white),),
                            const Text("Tracker", style: TextStyle(fontSize: 22, color: Colors.white60),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                ///////////////////////////////////////  ABOUT LIFE  //////////////////////////////////
                const Text("About Life", style: TextStyle(fontSize: 26)),



                Row(
                  children: [

                    ////////////////////////////////  TO DO APP  ///////////////////////////////////
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ToDoPage()));
                      },
                      child: Container(
                        width: 173,
                        height: 216,
                        decoration: BoxDecoration(
                          color: const Color(0xff8D0202),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black,
                            width: 3,
                          ),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black87,
                                offset: Offset(5, 5),
                                blurRadius: 10
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("images/todo.jpg", width: 500),
                            const Text("To Do", style: TextStyle(fontSize: 22, color: Colors.white),),
                            const Text("App", style: TextStyle(fontSize: 22, color: Colors.white60),),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    //////////////////////////////////////////  HABIT TRACKER  ////////////////////////////////
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const HabitTrackerPage()));
                      },
                      child: Container(
                        width: 173,
                        height: 216,
                        decoration: BoxDecoration(
                          color:const  Color(0xff8D0202),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black,
                            width: 3,
                          ),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black87,
                                offset: Offset(5, 5),
                                blurRadius: 10
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("images/process.png", width: 120),
                            const Text("Habit", style: TextStyle(fontSize: 22, color: Colors.white),),
                            const Text("Tracker", style: TextStyle(fontSize: 22, color: Colors.white60),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          ///////////////////////////////////////////////////  NAVIGATION BAR  /////////////////////////////////
          bottomNavigationBar: GoogleBottomNavigationBar(selectedIndex: 0),
        ),
      ),
    );
  }
}
