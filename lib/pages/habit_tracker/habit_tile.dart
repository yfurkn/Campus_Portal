import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HabitTile extends StatelessWidget {

  final String habitName;
  final VoidCallback onTap;
  final VoidCallback settingsTapped;
  final int timeSpent;
  final int timeGoal;
  final bool habitStarted;

  const HabitTile({Key? key, required this.habitName, required this.onTap, required this.settingsTapped, required this.timeSpent, required this.timeGoal, required this.habitStarted}) : super(key: key);

  // convert seconds into min:sec -> e.g. 62 sec = 1:02 min
  String convertToMinSec(int totalSeconds){
    String secs = (totalSeconds % 60).toString();
    String mins = (totalSeconds / 60).toStringAsFixed(5);

    //if secs is a 1 digit number, place a 0 in front of it
    if(secs.length == 1){
      secs = "0" + secs;
    }

    if(mins[1] == "."){
      mins = mins.substring(0, 1);
    }

    return mins + ":" + secs;
  }

  // calculate the progress percentage
  double percentCompleted() {
    return timeSpent / (timeGoal*60);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    height: 60,
                    width: 60,
                    child: Stack(
                      children: [
                        //progress circle
                        CircularPercentIndicator(
                          radius: 30,
                          percent: percentCompleted() < 1 ? percentCompleted() : 1,
                          progressColor: percentCompleted() == 1 ? Colors.green : Colors.red,
                        ),

                        //play pause button
                        Center(child: Icon(habitStarted ? Icons.pause : Icons.play_arrow))
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(habitName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),), // habit name

                    SizedBox(height: 4),

                    Text(
                      convertToMinSec(timeSpent) + " / " + timeGoal.toString() + " = " + (100*percentCompleted()).toStringAsFixed(0) + "%",
                      style: TextStyle(color: Colors.grey),
                    ), // progress
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: settingsTapped,
                child: Icon(Icons.settings)
            ),
          ],
        ),
      ),
    );
  }
}
