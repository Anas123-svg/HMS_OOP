import 'package:flutter/material.dart';
import 'package:kk/Helps/Utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kk/screen/DoctorScreen.dart';
import 'package:table_calendar/table_calendar.dart';




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
  final int serialNumber;
  final String diagnosis;
  final int bedNumber;
  final String condition;

  Patient({
    required this.name,
    required this.serialNumber,
    required this.diagnosis,
    required this.bedNumber,
    required this.condition,
  });
}


class Patients extends StatelessWidget {
  final List<Patient> patientsList = [
    Patient(
      name: 'John Doe',
      serialNumber: 1,
      diagnosis: 'Fever',
      bedNumber: 101,
      condition: 'Stable',
    ),
    Patient(
      name: 'Jane Smith',
      serialNumber: 2,
      diagnosis: 'Fractured Arm',
      bedNumber: 102,
      condition: 'Critical',
    ),
        Patient(
      name: 'Jane Smith',
      serialNumber: 2,
      diagnosis: 'Fractured Arm',
      bedNumber: 102,
      condition: 'Critical',
    ),
        Patient(
      name: 'Jane Smith',
      serialNumber: 2,
      diagnosis: 'Fractured Arm',
      bedNumber: 102,
      condition: 'Critical',
    ),

        Patient(
      name: 'Jane Smith',
      serialNumber: 2,
      diagnosis: 'Fractured Arm',
      bedNumber: 102,
      condition: 'Critical',
    ),
        Patient(
      name: 'Jane Smith',
      serialNumber: 2,
      diagnosis: 'Fractured Arm',
      bedNumber: 102,
      condition: 'Critical',
    ),
        Patient(
      name: 'Jane Smith',
      serialNumber: 2,
      diagnosis: 'Fractured Arm',
      bedNumber: 102,
      condition: 'Critical',
    ),
            Patient(
      name: 'Jane Smith',
      serialNumber: 2,
      diagnosis: 'Fractured Arm',
      bedNumber: 102,
      condition: 'Critical',
    ),
        Patient(
      name: 'Jane Smith',
      serialNumber: 2,
      diagnosis: 'Fractured Arm',
      bedNumber: 102,
      condition: 'Critical',
    ),

        Patient(
      name: 'Jane Smith',
      serialNumber: 2,
      diagnosis: 'Fractured Arm',
      bedNumber: 102,
      condition: 'Critical',
    ),
        Patient(
      name: 'Jane Smith',
      serialNumber: 2,
      diagnosis: 'Fractured Arm',
      bedNumber: 102,
      condition: 'Critical',
    ),
        Patient(
      name: 'Jane Smith',
      serialNumber: 2,
      diagnosis: 'Fractured Arm',
      bedNumber: 102,
      condition: 'Critical',
    ),
            Patient(
      name: 'Jane Smith',
      serialNumber: 2,
      diagnosis: 'Fractured Arm',
      bedNumber: 102,
      condition: 'Critical',
    ),
        Patient(
      name: 'Jane Smith',
      serialNumber: 2,
      diagnosis: 'Fractured Arm',
      bedNumber: 102,
      condition: 'Critical',
    ),

        Patient(
      name: 'Jane Smith',
      serialNumber: 2,
      diagnosis: 'Fractured Arm',
      bedNumber: 102,
      condition: 'Critical',
    ),
        Patient(
      name: 'Jane Smith',
      serialNumber: 2,
      diagnosis: 'Fractured Arm',
      bedNumber: 102,
      condition: 'Critical',
    ),
        Patient(
      name: 'Jane Smith',
      serialNumber: 2,
      diagnosis: 'Fractured Arm',
      bedNumber: 102,
      condition: 'Critical',
    ),
    // Add more patients as needed
  ];

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
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(                        'List of Patients',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                          ),
                          Spacer(),
/*
                          Icon(Icons.list, size: 60,
                          
                          ),*/
                        ],

                      ),
                    ),
                    DataTable(
                      columns: [
                        DataColumn(label: Text('Sr. No')),
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Bed No')),
                        DataColumn(label: Text('Diagnosis')),
                        DataColumn(label: Text('Condition')),
                      ],
                      rows: patientsList.map((patient) {
                        return DataRow(
                          cells: [
                            DataCell(Text(patient.serialNumber.toString())),
                            DataCell(Text(patient.name)),
                            DataCell(Text(patient.bedNumber.toString())),
                            DataCell(Text(patient.diagnosis)),
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

  const PatientDetails({Key? key, required this.patient}) : super(key: key);

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
            Text('Name: ${patient.name}'),
            Text('Sr. No: ${patient.serialNumber}'),
            Text('Bed No: ${patient.bedNumber}'),
            Text('Diagnosis: ${patient.diagnosis}'),
            Text('Condition: ${patient.condition}'),
          ],
        ),
      ),
    );
  }
}