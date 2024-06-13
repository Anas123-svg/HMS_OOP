import 'package:flutter/material.dart';
import 'package:kk/screen/HomeScreen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InOutPatientData {
  final String day;
  final int inPatientsCount;
  final int outPatientsCount;
  final int admitted;

  InOutPatientData({
    required this.day,
    required this.inPatientsCount,
    required this.outPatientsCount,
    required this.admitted,
  });

  factory InOutPatientData.fromJson(String day, Map<String, dynamic> json) {
    return InOutPatientData(
      day: day,
      inPatientsCount: json['inPatients'] != null ? int.parse(json['inPatients'].toString()) : 0,
      outPatientsCount: json['outPatients'] != null ? int.parse(json['outPatients'].toString()) : 0,
      admitted: json['admitted']!= null ? int.parse(json['admitted'].toString()) : 0,
    );
  }
}

Future<List<InOutPatientData>> fetchInPatients() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/inpatients'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => InOutPatientData.fromJson("", data)).toList();
  } else {
    throw Exception('Failed to load in-patients data');
  }
}

Future<List<InOutPatientData>> fetchOutPatients() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/outpatients'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => InOutPatientData.fromJson("", data)).toList();
  } else {
    throw Exception('Failed to load out-patients data');
  }
}

Future<List<InOutPatientData>> fetchPatientCountsByDay() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/patient-count-by-day'));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.entries.map((entry) => InOutPatientData.fromJson(entry.key, entry.value)).toList();
  } else {
    throw Exception('Failed to load patient counts data');
  }
}

class DoctorScreen extends StatefulWidget {
  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  late Future<List<InOutPatientData>> inPatientsData;
  late Future<List<InOutPatientData>> outPatientsData;
  late Future<List<InOutPatientData>> patientCountsData;

  @override
  void initState() {
    super.initState();
    inPatientsData = fetchInPatients();
    outPatientsData = fetchOutPatients();
    patientCountsData = fetchPatientCountsByDay();
  }

List<BarChartGroupData> generateBarGroups(List<InOutPatientData> data) {
  List<String> daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

  
  Map<String, BarChartGroupData> dayDataMap = {};


  for (String day in daysOfWeek) {
    dayDataMap[day] = BarChartGroupData(
      x: daysOfWeek.indexOf(day),
      barRods: [
        BarChartRodData(y: 0, colors: [Colors.transparent], width: 20, borderRadius: BorderRadius.zero),
        BarChartRodData(y: 0, colors: [Colors.transparent], width: 20, borderRadius: BorderRadius.zero),
      ],
    );
  }


  for (InOutPatientData item in data) {
    int inPatientsCount = item.inPatientsCount;
    int outPatientsCount = item.outPatientsCount;

    dayDataMap[item.day] = BarChartGroupData(
      x: daysOfWeek.indexOf(item.day),
      barRods: [
        BarChartRodData(y: inPatientsCount.toDouble(), colors: [Colors.blue], width: 20, borderRadius: BorderRadius.zero),
        //BarChartRodData(y: outPatientsCount.toDouble(), colors: [Colors.green], width: 20, borderRadius: BorderRadius.zero),
      ],
    );
  }

 
  return dayDataMap.values.toList();
}



List<BarChartGroupData> generateBarGroups2(List<InOutPatientData> data) {
  List<String> daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

  
  Map<String, BarChartGroupData> dayDataMap = {};


  for (String day in daysOfWeek) {
    dayDataMap[day] = BarChartGroupData(
      x: daysOfWeek.indexOf(day),
      barRods: [
        BarChartRodData(y: 0, colors: [Colors.transparent], width: 20, borderRadius: BorderRadius.zero),
        BarChartRodData(y: 0, colors: [Colors.transparent], width: 20, borderRadius: BorderRadius.zero),
      ],
    );
  }


  for (InOutPatientData item in data) {
    int inPatientsCount = item.inPatientsCount;
    int outPatientsCount = item.outPatientsCount;

    dayDataMap[item.day] = BarChartGroupData(
      x: daysOfWeek.indexOf(item.day),
      barRods: [
        //BarChartRodData(y: inPatientsCount.toDouble(), colors: [Colors.blue], width: 20, borderRadius: BorderRadius.zero),
        BarChartRodData(y: outPatientsCount.toDouble(), colors: [Colors.green], width: 20, borderRadius: BorderRadius.zero),
      ],
    );
  }

 
  return dayDataMap.values.toList();
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            CustomSidePanel(), 
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
                            color: Color.fromARGB(255, 255, 255, 255),
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
                          Container_For_doctor_panel(
                            Label: 'In Patients :',
                            x: "2",
                            cl: Color.fromARGB(255, 7, 133, 237),
                            iconData: Icons.people,
                          ),
                          Spacer(),
                                                    Container_For_doctor_panel(
                            Label: 'In Patients :',
                            x: "2",
                            cl: Color.fromARGB(255, 7, 133, 237),
                            iconData: Icons.people,
                          ),
                          Spacer(),
                                                    Container_For_doctor_panel(
                            Label: 'In Patients :',
                            x: "2",
                            cl: Color.fromARGB(255, 7, 133, 237),
                            iconData: Icons.people,
                          ),
                          Spacer(),
                                                    Container_For_doctor_panel(
                            Label: 'In Patients :',
                            x: "2",
                            cl: Color.fromARGB(255, 7, 133, 237),
                            iconData: Icons.people,
                          ),
                                                    Spacer(),
                                                    Container_For_doctor_panel(
                            Label: 'In Patients :',
                            x: "2",
                            cl: Color.fromARGB(255, 7, 133, 237),
                            iconData: Icons.people,
                          ),
                          
                    
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
                            child: FutureBuilder<List<InOutPatientData>>(
                              future: patientCountsData,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                } else if(snapshot.hasError) {
                                  return Center(child: Text('Error: ${snapshot.error}'));
                                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                  return Center(child: Text('No patient counts data found'));
                                }
                                 List<InOutPatientData> admittedPatients =
                                    snapshot.data!.where((patient) => patient.outPatientsCount>=1).toList(); 
                                return Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Patient Consultations by Day',
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
                                                barGroups: generateBarGroups2(admittedPatients), 
                                                borderData: FlBorderData(show: true),
                                                titlesData: FlTitlesData(
                                                  leftTitles: SideTitles(showTitles: true),
                                                  bottomTitles: SideTitles(
                                                    showTitles: true,
                                                     getTitles: (value) {
          
          List<String> daysOfWeek = ['Mon', 'Tuesday', 'Wed', 'Thursday', 'Fri', 'Saturday', 'Sun'];
          int index = value.toInt();
          if (index >= 0 && index < daysOfWeek.length) {
            return daysOfWeek[index];
          }
          return '';
        },
                                                  
                                                  ),
                                                  
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                                                    Expanded(
                            child: FutureBuilder<List<InOutPatientData>>(
                              future: patientCountsData,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                } else if(snapshot.hasError) {
                                  return Center(child: Text('Error: ${snapshot.error}'));
                                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                  return Center(child: Text('No patient counts data found'));
                                }
                                
                                   List<InOutPatientData> admittedPatients =
                                    snapshot.data!.where((patient) => patient.inPatientsCount>=1).toList(); 
                          
                                return Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'In Patients',
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
                                                barGroups: generateBarGroups(admittedPatients), 
                                                borderData: FlBorderData(show: true),
                                                titlesData: FlTitlesData(
                                                  leftTitles: SideTitles(showTitles: true),
                                                  bottomTitles: SideTitles(
                                                    showTitles: true,
                                                                                                         getTitles: (value) {
          
          List<String> daysOfWeek = ['Mon', 'Tuesday', 'Wed', 'Thursday', 'Fri', 'Saturday', 'Sun'];
          int index = value.toInt();
          if (index >= 0 && index < daysOfWeek.length) {
            return daysOfWeek[index];
          }
          return '';
        },
                                                    ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
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