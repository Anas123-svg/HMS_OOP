import 'package:flutter/material.dart';
import 'package:kk/screen/HomeScreen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';
class DoctorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [

            CutomSidePanel(context),


            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  color: Colors.grey[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
Card(
  elevation: 20,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: BorderSide(color: Colors.black), 
  ),
  child: Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 7, 133, 237),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(
      child: Text(
        "Doctor's Panel",
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
),


                                  Row(
              children: [
                Container_For_doctor_panel(Label: 'In Patients :',x: "2",cl:Color.fromARGB(255, 7, 133, 237),iconData: Icons.people,),
                Spacer(),
                Container_For_doctor_panel(Label: 'OutPatients:',x:"3", cl: Color.fromARGB(255, 7, 133, 237),iconData: Icons.people),
                Spacer(),
                Container_For_doctor_panel(Label: 'Schedule',x:"", cl: Color.fromARGB(255, 7, 133, 237),iconData: Icons.schedule,),
                                Spacer(),
                Container_For_doctor_panel(Label: 'Labs :',x: "6", cl: Color.fromARGB(255, 7, 133, 237),iconData:Icons.local_hospital),
                Spacer(),
                Container_For_doctor_panel(Label: 'Reports :',x: "6", cl: Color.fromARGB(255, 7, 133, 237), iconData:Icons.assignment),
              ],

            ),
                      Text(
                        'Consultations and Appointments',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [

                          Expanded(
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'In-Patient Consultations',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 16.0),
                                      child: SizedBox(
                                        height: 200, 
                                        child: BarChart(
                                          BarChartData(
                                            barGroups: [
                                              BarChartGroupData(
                                                x: 1,
                                                barRods: [
                                                  BarChartRodData(
                                                    y: 5,
                                                    colors: [Colors.blue],
                                                    width: 60,
                                                    borderRadius: BorderRadius.zero,
                                                  ),
                                                ],
                                              ),
                                              BarChartGroupData(
                                                x: 2,
                                                barRods: [
                                                  BarChartRodData(
                                                    y: 6,
                                                    colors: [Colors.blue],
                                                    width: 60,
                                                    borderRadius: BorderRadius.zero,
                                                  ),
                                                ],
                                              ),
                                              BarChartGroupData(
                                                x: 3,
                                                barRods: [
                                                  BarChartRodData(
                                                    y: 7,
                                                    colors: [Colors.blue],
                                                    width: 60,
                                                    borderRadius: BorderRadius.zero,
                                                  ),
                                                ],
                                              ),
                                              BarChartGroupData(
                                                x: 4,
                                                barRods: [
                                                  BarChartRodData(
                                                    y: 8,
                                                    colors: [Colors.blue],
                                                    width: 60,
                                                    borderRadius: BorderRadius.zero,
                                                  ),
                                                ],
                                              ),
                                              BarChartGroupData(
                                                x: 5,
                                                barRods: [
                                                  BarChartRodData(
                                                    y: 9,
                                                    colors: [Colors.blue],
                                                    width: 60,
                                                    borderRadius: BorderRadius.zero,
                                                  ),
                                                ],
                                              ),
                                            ],
                                            borderData: FlBorderData(show: false),
                                            titlesData: FlTitlesData(
                                              leftTitles: SideTitles(showTitles: false),
                                              bottomTitles: SideTitles(showTitles: true),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),

                          Expanded(
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Out-Patient Consultations',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 16.0),
                                      child: SizedBox(
                                        height: 200, 
                                        child: BarChart(
                                          BarChartData(
                                            barGroups: [
                                              BarChartGroupData(
                                                x: 1,
                                                barRods: [
                                                  BarChartRodData(
                                                    y: 10,
                                                    colors: [Colors.green],
                                                    width: 60,
                                                    borderRadius: BorderRadius.zero,
                                                  ),
                                                ],
                                              ),
                                              BarChartGroupData(
                                                x: 2,
                                                barRods: [
                                                  BarChartRodData(
                                                    y: 12,
                                                    colors: [Colors.green],
                                                    width: 60,
                                                    borderRadius: BorderRadius.zero,
                                                  ),
                                                ],
                                              ),
                                              BarChartGroupData(
                                                x: 3,
                                                barRods: [
                                                  BarChartRodData(
                                                    y: 8,
                                                    colors: [Colors.green],
                                                    width: 60,
                                                    borderRadius: BorderRadius.zero,
                                                  ),
                                                ],
                                              ),
                                              BarChartGroupData(
                                                x: 4,
                                                barRods: [
                                                  BarChartRodData(
                                                    y: 11,
                                                    colors: [Colors.green],
                                                    width: 60,
                                                    borderRadius: BorderRadius.zero,
                                                  ),
                                                ],
                                              ),
                                              BarChartGroupData(
                                                x: 5,
                                                barRods: [
                                                  BarChartRodData(
                                                    y: 7,
                                                    colors: [Colors.green],
                                                    width: 60,
                                                    borderRadius: BorderRadius.zero,
                                                  ),
                                                ],
                                              ),
                                              BarChartGroupData(
                                                x: 6,
                                                barRods: [
                                                  BarChartRodData(
                                                    y: 9,
                                                    colors: [Colors.green],
                                                    width: 60,
                                                    borderRadius: BorderRadius.zero,
                                                  ),
                                                ],
                                              ),
                                            ],
                                            borderData: FlBorderData(show: false),
                                            titlesData: FlTitlesData(
                                              leftTitles: SideTitles(showTitles: false),
                                              bottomTitles: SideTitles(showTitles: true),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 5,
                              child: Container(
                                height: 400,
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Appointments',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: SingleChildScrollView(
                                          child: DataTable(
                                            columns: [
                                              DataColumn(label: Text('Date')),
                                              DataColumn(label: Text('Patient')),
                                              DataColumn(label: Text('Time')),
                                              DataColumn(label: Text('Doctor')),
                                            ],
                                            rows: List<DataRow>.generate(
                                              10, 
                                              (index) => DataRow(cells: [
                                                DataCell(Text('2023-05-21')),
                                                DataCell(Text('Patient $index')),
                                                DataCell(Text('10:00 AM')),
                                                DataCell(Text('Dr. xyz')),
                                              ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Card(
                              elevation: 5,
                              child: Container(
                                height: 400,
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Calendar',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: TableCalendar(
                                          focusedDay: DateTime.now(),
                                          firstDay: DateTime.now().subtract(Duration(days: 365)),
                                          lastDay: DateTime.now().add(Duration(days: 365)),
                                          calendarFormat: CalendarFormat.month,
                                          headerStyle: HeaderStyle(
                                            formatButtonVisible: false,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Container CutomSidePanel(BuildContext context) {
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



class Container_For_doctor_panel extends StatelessWidget {
  final String x;
  final String Label;
  final Color cl;
  final IconData iconData; 

  const Container_For_doctor_panel({
    Key? key,
    required this.Label,
    required this.x,
    required this.cl,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      child: Card(
        elevation: 20,
        color: cl,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    iconData,
                    color: Colors.white,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    Label,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Text(
                x,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}