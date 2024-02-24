import 'package:campus_portal_project/pages/info_page.dart';
import 'package:campus_portal_project/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../pages/home_page.dart';

class GoogleBottomNavigationBar extends StatelessWidget {

  int selectedIndex;
  GoogleBottomNavigationBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: const BorderRadius.only(topLeft:Radius.circular(15), topRight:Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: GNav(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            selectedIndex: selectedIndex,
            gap: 10,
            backgroundColor: Colors.grey.shade300,
            color: Colors.black,
            activeColor: Colors.black,
            tabBackgroundColor: Colors.grey.shade100,
            padding: const EdgeInsets.all(16),
            hoverColor: Colors.red,
            tabActiveBorder: Border.all(color: Colors.black, width: 2), // tab button border
            tabBorder: Border.all(color: Colors.grey, width: 1), // tab button border
            onTabChange: (index){
              if(index == 0) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
              }
              else if(index == 1) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
              }
              else if(index == 2) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const InfoPage()));
              }
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.account_circle,
                text: 'Profile',
              ),
              GButton(
                icon: Icons.info,
                text: 'Info',
              ),
            ]
        ),
      ),
    );
  }
}