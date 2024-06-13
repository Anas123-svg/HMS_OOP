

import 'package:flutter/material.dart';
import 'package:kk/Helps/Utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kk/screen/DoctorScreen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:kk/screen/loginScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:kk/screen/HomeScreen.dart';
class CustomSidePanel extends StatelessWidget {
  final doctorName;
  const CustomSidePanel({Key? key, required this.doctorName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromARGB(255, 7, 133, 237),
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/logo.png', height: 80),
                  SizedBox(height: 10),
                  Text(
                    'Doctor Panel',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard, color: Colors.white),
              title: Text('Dashboard', style: TextStyle(color: Colors.white)),
              onTap: () {
                                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorScreen(doctorName: doctorName,)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.people, color: Colors.white),
              title: Text('patients', style: TextStyle(color: Colors.white)),
              onTap: () {
                                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Patients(doctorName: doctorName,)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.white),
              title: Text('Appointments', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Appointments(doctorName: doctorName,)),
                );
              },
            ),
                                    ListTile(
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text('Logout', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            ),
          ],
        ),
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
  final String notes;

  Patient({
    required this.name,
    required this.serialNumber,
    required this.diagnosis,
    required this.bedNumber,
    required this.condition,
    required this.admitted,
    required this.date,
    this.notes = '',
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
      notes: json['notes']??'',
    );
  }
}



class Patients extends StatefulWidget {
  final String doctorName;

  const Patients({Key? key, required this.doctorName}) : super(key: key);
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
            CustomSidePanel(doctorName: widget.doctorName),
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


class PatientDetails extends StatefulWidget {
  final Patient patient;

  PatientDetails({required this.patient});

  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  late TextEditingController _nameController;
  late TextEditingController _serialNumberController;
  late TextEditingController _diagnosisController;
  late TextEditingController _bedNumberController;
  late TextEditingController _conditionController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.patient.name);
    _serialNumberController = TextEditingController(text: widget.patient.serialNumber);
    _diagnosisController = TextEditingController(text: widget.patient.diagnosis);
    _bedNumberController = TextEditingController(text: widget.patient.bedNumber.toString());
    _conditionController = TextEditingController(text: widget.patient.condition);
    _notesController = TextEditingController(text: widget.patient.notes);

    // Add listeners to update state on text change
    _nameController.addListener(_updateState);
    _serialNumberController.addListener(_updateState);
    _diagnosisController.addListener(_updateState);
    _bedNumberController.addListener(_updateState);
    _conditionController.addListener(_updateState);
    _notesController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.removeListener(_updateState);
    _serialNumberController.removeListener(_updateState);
    _diagnosisController.removeListener(_updateState);
    _bedNumberController.removeListener(_updateState);
    _conditionController.removeListener(_updateState);
    _notesController.removeListener(_updateState);

    _nameController.dispose();
    _serialNumberController.dispose();
    _diagnosisController.dispose();
    _bedNumberController.dispose();
    _conditionController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _updatePatientDetails() async {
    try {
      final response = await http.put(
        Uri.parse('http://127.0.0.1:8000/api/patients/${widget.patient.serialNumber}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': _nameController.text,
          'serial_number': _serialNumberController.text,
          'diagnosis': _diagnosisController.text,
          'bed_number': _bedNumberController.text,
          'condition': _conditionController.text,
          'notes': _notesController.text,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Patient details updated successfully')));
      } else {
        throw Exception('Failed to update patient details');
      }
    } catch (error) {
      print('Error updating patient details: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update patient details')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display patient details
              _buildDetailText('Name: ${_nameController.text}'),
              _buildDetailText('Serial Number: ${_serialNumberController.text}'),
              _buildDetailText('Diagnosis: ${_diagnosisController.text}'),
              _buildDetailText('Bed Number: ${_bedNumberController.text}'),
              _buildDetailText('Condition: ${_conditionController.text}'),
              _buildDetailText('Admitted: ${widget.patient.admitted == 1 ? 'Yes' : 'No'}'),
              _buildDetailText('Date: ${widget.patient.date.toString()}'),
              _buildDetailText('Notes: ${_notesController.text}'),
              SizedBox(height: 20),
              // Editable text fields
              _buildTextField('Name', _nameController),
              _buildTextField('Serial Number', _serialNumberController),
              _buildTextField('Diagnosis', _diagnosisController),
              _buildTextField('Bed Number', _bedNumberController),
              _buildTextField('Condition', _conditionController),
              _buildTextField('Notes', _notesController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updatePatientDetails,
                child: Text('Update Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailText(String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        detail,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
