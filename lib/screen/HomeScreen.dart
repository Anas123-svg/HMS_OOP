import 'package:flutter/material.dart';
import 'package:kk/Helps/Utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kk/screen/DoctorScreen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      drawer: customDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CuSiz(width: 200.0, height: 200.0, image: 'images/logo.png'),
            const SizedBox(height: 10.0),
            Text(
              'Welcome to Home Screen',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSidePanel extends StatelessWidget {
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
                  builder: (BuildContext context) => HomeScreen(),
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
                  builder: (BuildContext context) => HomeScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Patient {
  final String name;
  final String serialNumber;
  final String diagnosis;
  final int bedNumber;
  final String condition;
  final int admitted;
  final DateTime date;

  Patient({
    required this.name,
    required this.serialNumber,
    required this.diagnosis,
    required this.bedNumber,
    required this.condition,
    required this.admitted,
    required this.date,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      name: json['name'],
      serialNumber: json['serialNumber'],
      diagnosis: json['diagnosis'],
      bedNumber: json['bedNumber'],
      condition: json['condition'],
      admitted: json['admitted'],
      date: DateTime.parse(json['date']),
    );
  }
}



class Patients extends StatefulWidget {
  @override
  _PatientsState createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  late Future<List<Patient>> patientsList;

  @override
  void initState() {
    super.initState();
    patientsList = fetchPatients();
  }

Future<List<Patient>> fetchPatients() async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/patients'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((patient) => Patient.fromJson(patient)).toList();
    } else {
      throw Exception('Failed to load patients: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching patients: $error');
    throw Exception('Failed to load patients: $error');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients List'),
      ),
      body: SafeArea(
        child: Row(
          children: [
            CustomSidePanel(),
            Expanded(
              child: FutureBuilder<List<Patient>>(
                future: patientsList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Patient> patients = snapshot.data!;
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Text(
                                  'List of Patients',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          DataTable(
                            columns: [
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('Sr. No')),
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Bed No')),
                              DataColumn(label: Text('Diagnosis')),
                              DataColumn(label: Text('Admitted')),
                              DataColumn(label: Text('Condition')),
                            ],
                            rows: patients.map((patient) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(patient.date.toString())),
                                  DataCell(Text(patient.serialNumber.toString())),
                                  DataCell(Text(patient.name)),
                                  DataCell(Text(patient.bedNumber.toString())),
                                  DataCell(Text(patient.diagnosis)),
                                  DataCell(Text(patient.admitted == 1 ? 'true' : 'false')),
                                  DataCell(
                                    Text(
                                      patient.condition,
                                      style: TextStyle(
                                        color: patient.condition == 'Critical' ? Colors.red : Colors.green,
                                      ),
                                    ),
                                  ),
                                ],
                                onSelectChanged: (_) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => PatientDetails(patient: patient),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class PatientDetails extends StatelessWidget {
  final Patient patient;

  PatientDetails({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${patient.name}', style: TextStyle(fontSize: 18)),
            Text('Serial Number: ${patient.serialNumber}', style: TextStyle(fontSize: 18)),
            Text('Diagnosis: ${patient.diagnosis}', style: TextStyle(fontSize: 18)),
            Text('Bed Number: ${patient.bedNumber}', style: TextStyle(fontSize: 18)),
            Text('Condition: ${patient.condition}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}