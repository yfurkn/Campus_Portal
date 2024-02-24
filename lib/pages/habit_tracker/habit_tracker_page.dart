import 'dart:async';

import 'package:flutter/material.dart';

import '../home_page.dart';
import 'habit_tile.dart';

class HabitTrackerPage extends StatefulWidget {
  const HabitTrackerPage({Key? key}) : super(key: key);

  @override
  State<HabitTrackerPage> createState() => _HabitTrackerPageState();
}

class _HabitTrackerPageState extends State<HabitTrackerPage> {

  TextEditingController habitNameController = TextEditingController();
  TextEditingController timeGoalController = TextEditingController();

  // overall habit summary
  List habitList = [
    // [ habitName, habitStarted, timeSpent(sec), timeGoal(min) ]
    //["Exercise", false, 0, 1],
  ];

  // FAB add with AlertDialog
  void openSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Habit"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: habitNameController,
                decoration: const InputDecoration(hintText: 'Habit Name'),
              ),
              TextField(
                controller: timeGoalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Time Goal (min)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // AlertDialog'ı kapat
                habitNameController.text = "";
                timeGoalController.text = "";
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // habitList'e ekleme yap ve AlertDialog'ı kapat
                setState(() {
                  habitList.add([
                    habitNameController.text,
                    false,
                    0,
                    int.parse(timeGoalController.text)
                  ]);
                });
                habitNameController.text = "";
                timeGoalController.text = "";
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void habitStarted(int index){
    // note what the start time is
    var startTime = DateTime.now();

    // include the time already elapsed
    int elapsedTime = habitList[index][2];

    // habit started or stopped
    setState(() {
      habitList[index][1] = !habitList[index][1];
    });

    if(habitList[index][1]) {
      //keep the time going!
      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          // check when the user has stopped the timer
          if(!habitList[index][1]){
            timer.cancel();
          }

          // calculate the time elapsed by comparing current time and start time
          var currentTime = DateTime.now();
          habitList[index][2] = elapsedTime + currentTime.second - startTime.second +
              60*(currentTime.minute - startTime.minute) +
              60*60*(currentTime.hour - startTime.hour);
        });
      });
    }
  }

  void settingsOpened(int index){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Settings for " + habitList[index][0]),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: habitNameController,
                  decoration: InputDecoration(hintText: habitList[index][0]),

                ),
                TextField(
                  controller: timeGoalController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: habitList[index][3].toString()),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    habitList.removeAt(index);
                  });
                  Navigator.of(context).pop(); // AlertDialog'ı kapat
                  habitNameController.text = "";
                  timeGoalController.text = "";
                },
                child: const Text('Delete', style: TextStyle(color: Colors.red)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // AlertDialog'ı kapat
                  habitNameController.text = "";
                  timeGoalController.text = "";
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // habitList'e ekleme yap ve AlertDialog'ı kapat
                  setState(() {
                    habitList[index][0] = habitNameController.text;
                    habitList[index][3] = int.parse(timeGoalController.text);
                  });
                  habitNameController.text = "";
                  timeGoalController.text = "";
                  Navigator.of(context).pop();
                },
                child: const Text('Save', style: TextStyle(color: Colors.green)),
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
          title: const Text("Habit Tracker",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),

        body: ListView.builder(
          itemCount: habitList.length,
          itemBuilder: ((context, index) {
            return HabitTile(
              habitName: habitList[index][0],
              habitStarted: habitList[index][1],
              timeSpent: habitList[index][2],
              timeGoal: habitList[index][3],
              onTap: (){
                habitStarted(index);
              },
              settingsTapped: (){
                settingsOpened(index);
              },
            );
          }),
        ),


        floatingActionButton: SizedBox(
          height: 50,
          width: 50,
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            child: const Icon(Icons.add, color: Colors.white, size: 40),
            onPressed: (){
              openSettingsDialog();
            },
          ),
        ),
      ),
    );
  }
}
