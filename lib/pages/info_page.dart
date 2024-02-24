import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utility/bottom_navigation_bar.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {

  void _launchLinkedin() async {
    const String url = "https://www.linkedin.com/in/furkan-y%C4%B1lmaz-211081239/";
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      print("açılmıyor");
    }
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
          title: const Text("Info",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              onPressed: (){
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              icon: const Icon(Icons.exit_to_app_outlined, size: 45, color: Colors.black38),
            ),
            const SizedBox(width: 15),
          ],
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: EdgeInsets.symmetric(vertical: size.height*0.06),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(
                        color: Colors.black,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: Image.asset("images/logo.png", width: 200, height: 200,),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Text("Portal Campus is an application where university students can do simple tasks with a clean interface.",
                    style: TextStyle(fontSize: 15),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Text("You can calculate Semester and General averages.",
                    style: TextStyle(fontSize: 15),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Text("You can also keep a to-do list and measure the duration of your tasks in order to be more organized and systematic in your daily life.",
                    style: TextStyle(fontSize: 15),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Text("Don't forget to rate us and comment.",
                    style: TextStyle(fontSize: 15),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Text("Good luck in your life.",
                    style: TextStyle(fontSize: 15),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Text("If you want to reach me, you can click on the Linkedin link below.",
                    style: TextStyle(fontSize: 15),
                  ),
                ),

                SizedBox(height: 20),

                Center(
                  child: GestureDetector(
                    onTap: (){
                      _launchLinkedin();
                    },
                    child: FaIcon(
                      FontAwesomeIcons.linkedin,
                      size: 50,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        bottomNavigationBar: GoogleBottomNavigationBar(selectedIndex: 2),
      ),
    );
  }
}
