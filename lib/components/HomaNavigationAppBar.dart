import 'package:flutter/material.dart';

class HomeNavigationBar extends StatefulWidget {
  const HomeNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  _HomeNavigationBarState createState() => _HomeNavigationBarState();
}

class _HomeNavigationBarState extends State<HomeNavigationBar> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: Theme.of(context).copyWith(
        // sets the background color of the `BottomNavigationBar`
        canvasColor: Colors.blue,
        // sets the active color of the `BottomNavigationBar` if `Brightness` is light
        primaryColor: Colors.red,
        textTheme: Theme.of(context).textTheme.copyWith(
              caption: new TextStyle(
                color: Colors.yellow,
              ),
            ),
      ),
      child: BottomNavigationBar(
        onTap: (s) {
          setState(() {
            selected = s;
          });
        },
        type: BottomNavigationBarType.shifting,
        elevation: 0,
        currentIndex: selected,
        selectedIconTheme: IconThemeData(color: Colors.green),
        selectedItemColor: Colors.greenAccent,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            // padding: EdgeInsets.only(left: 28.0),
            label: 'Messages',
            icon: Icon(
              Icons.chat,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Clinics',
            // padding: EdgeInsets.only(left: 28.0),
            icon: Icon(
              Icons.local_hospital_rounded,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Home',
            // padding: EdgeInsets.only(right: 28.0),
            icon: Icon(
              Icons.home_rounded,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Doctors',
            // padding: EdgeInsets.only(left: 28.0),
            icon: Icon(
              Icons.people_outline_rounded,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Notifications',
            // padding: EdgeInsets.only(right: 28.0),
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
