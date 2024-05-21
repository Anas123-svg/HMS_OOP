import 'package:flutter/material.dart';
import 'package:kk/Helps/Utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kk/screen/DoctorScreen.dart';
import 'package:table_calendar/table_calendar.dart';






class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: customAppbar(),
      drawer: customDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CuSiz(width: 200.0, height: 200.0, image: 'images/logo.png'),
            const SizedBox(height: 10.0),
            Text('Welcome to Home Screen', style: TextStyle(fontSize: 20.0, color: Colors.black),),
          ],
        ),
      ),
    );
  }
}





class CustomSidePanel extends StatelessWidget {
  final BuildContext context;

  CustomSidePanel(this.context);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: const Color.fromARGB(255, 7, 133, 237),
      child: Column(
        children: [
          DrawerHeader(child: Image.asset('images/logo.png')),
          ListTile(
            title: Text(
              "Dashboard",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => DoctorScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              "Patients",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Patients(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              "Appointments",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Patients(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              "Lab Reports",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Patients(),
                ),
              );
            },
          ),
      
        ],
      ),
    );
  }
}




class Patients extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients'),
      ),
      body: SafeArea(
        child: Row(
          children: [
            CustomSidePanel(context),
          ],
        ),
      ),
    );
  }
}
