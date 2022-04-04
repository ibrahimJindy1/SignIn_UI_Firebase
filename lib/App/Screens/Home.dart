import 'package:flutter/material.dart';
import 'package:random_social_network/components/PagesIndexed.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selected = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
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
          items: navBarItems,
        ),
      ),
      body: PagesIndexed(selected: selected),
    );
  }

  List<BottomNavigationBarItem> get navBarItems {
    return <BottomNavigationBarItem>[
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
    ];
  }
}
