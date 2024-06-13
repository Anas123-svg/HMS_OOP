import 'package:flutter/material.dart';
import 'package:kk/Helps/Utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kk/screen/DoctorScreen.dart';
import 'package:kk/screen/loginScreen.dart';
import 'package:kk/screen/PatientScreen.dart';
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

class User {
  final int id;
  final String name;
  final String email;
  final String designation;
  final String profilePhotoUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.designation,
    required this.profilePhotoUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      designation: json['designation'],
      profilePhotoUrl: json['profile_photo_url'],
    );
  }
}

class Appointment {
  final int id;
  final int patientId;
  final int doctorId;
  final DateTime appointmentDate;
  final String status;
  final String? notes;
  final Patient patient;
  final User doctor;

  Appointment({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.appointmentDate,
    required this.status,
    this.notes,
    required this.patient,
    required this.doctor,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      patientId: json['patient_id'],
      doctorId: json['doctor_id'],
      appointmentDate: DateTime.parse(json['appointment_date']),
      status: json['status'],
      notes: json['notes'] as String?,
      patient: Patient.fromJson(json['patient']),
      doctor: User.fromJson(json['doctor']),
    );
  }
}
class Appointments extends StatefulWidget {
  final String doctorName;

  const Appointments({Key? key, required this.doctorName}) : super(key: key);

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  late Future<List<Appointment>> appointmentList;
  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    appointmentList = fetchAppointments(widget.doctorName, selectedFilter);
  }

  Future<List<Appointment>> fetchAppointments(String doctorName, String selectedFilter) async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/appointments2/doctor/$doctorName'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        List<Appointment> appointments = jsonResponse.map<Appointment>((json) => Appointment.fromJson(json)).toList();
        if (selectedFilter == 'Visited') {
          appointments = appointments.where((appointment) => appointment.status == 'Visited').toList();
        } else if (selectedFilter == 'scheduled') {
          appointments = appointments.where((appointment) => appointment.status == 'scheduled').toList();
        }
        return appointments;
      } else {
        throw Exception('Failed to load appointments: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching appointments: $error');
      throw Exception('Failed to load appointments: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments List'),
      ),
      body: SafeArea(
        child: Row(
          children: [
            CustomSidePanel(doctorName: widget.doctorName,),
            Expanded(
              child: FutureBuilder<List<Appointment>>(
                future: appointmentList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Appointment> appointments = snapshot.data!;
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
                                          DropdownButton<String>(
            value: selectedFilter,
            onChanged: (String? newValue) {
              setState(() {
                selectedFilter = newValue!;
                appointmentList = fetchAppointments(widget.doctorName, selectedFilter);
              });
            },
            items: <String>['All', 'Visited', 'scheduled'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
                              ],
                            ),
                          ),
                          DataTable(
                            columns: [
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('Sr. No')),
                              DataColumn(label: Text('Patient Name')),
                              DataColumn(label: Text('Doctor Name')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Diagnosis')),
                              DataColumn(label: Text('Admitted')),
                              DataColumn(label: Text('Condition')),
                            ],
                            rows: appointments.map((_appointment) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(_appointment.appointmentDate.toString())),
                                  DataCell(Text(_appointment.patient.serialNumber)),
                                  DataCell(Text(_appointment.patient.name)),
                                  DataCell(Text(_appointment.doctor.name)),
                                  DataCell(Text(_appointment.status?.toString() ?? 'N/A')),
                                  DataCell(Text(_appointment.patient.diagnosis)),
                                  DataCell(Text(_appointment.patient.admitted == 1 ? 'true' : 'false')),
                                  DataCell(
                                    Text(
                                      _appointment.patient.condition,
                                      style: TextStyle(
                                        color: (_appointment.patient.condition == 'Critical') ? Colors.red : Colors.green,
                                      ),
                                    ),
                                  ),
                                ],
                                onSelectChanged: (_) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => AppointmentDetails(appointment: _appointment),
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


class AppointmentDetails extends StatefulWidget {
  final Appointment appointment;

  AppointmentDetails({required this.appointment});

  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  late TextEditingController _nameController;
  late TextEditingController _serialNumberController;
  late TextEditingController _diagnosisController;
  late TextEditingController _bedNumberController;
  late TextEditingController _conditionController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.appointment.patient.name);
    _serialNumberController = TextEditingController(text: widget.appointment.patient.serialNumber);
    _diagnosisController = TextEditingController(text: widget.appointment.patient.diagnosis);
    _bedNumberController = TextEditingController(text: widget.appointment.patient.bedNumber.toString());
    _conditionController = TextEditingController(text: widget.appointment.patient.condition);
    _notesController = TextEditingController(text: widget.appointment.patient.notes);

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
        Uri.parse('http://127.0.0.1:8000/api/patients/${widget.appointment.patient.serialNumber}'),
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
              print('Failed to mark appointment as visited. Response code: ${response.statusCode}');
      print(response.body);
        throw Exception('Failed to update patient details');
      }
    } catch (error) {
      print('Error updating patient details: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update patient details')));
    }
  }

Future<void> _markAsVisited() async {
  try {
    final response = await http.put(
      Uri.parse('http://127.0.0.1:8000/api/appointments2/${widget.appointment.id}'), // Use appointment ID
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'status': 'Visited',
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Appointment marked as visited')));
    } else {
      print('Failed to mark appointment as visited. Response code: ${response.statusCode}');
      print(response.body);
      throw Exception('Failed to mark appointment as visited');

    }
  } catch (error) {
    print('Error marking appointment as visited: $error');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to mark appointment as visited')));
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailText('Patient Name: ${_nameController.text}'),
              _buildDetailText('Serial Number: ${_serialNumberController.text}'),
              _buildDetailText('Diagnosis: ${_diagnosisController.text}'),
              _buildDetailText('Bed Number: ${_bedNumberController.text}'),
              _buildDetailText('Condition: ${_conditionController.text}'),
              _buildDetailText('Admitted: ${widget.appointment.patient.admitted == 1 ? 'Yes' : 'No'}'),
              _buildDetailText('Date: ${widget.appointment.patient.date.toString()}'),
              _buildDetailText('Notes: ${_notesController.text}'),
              SizedBox(height: 20),
              Text('Edit Patient Details:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _markAsVisited,
                child: Text('Mark as Visited'),
              ),
              SizedBox(height: 20),
              Text('Doctor Details:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildDetailText('Doctor Name: ${widget.appointment.doctor.name}'),
              _buildDetailText('Doctor Email: ${widget.appointment.doctor.email}'),
              _buildDetailText('Appointment Date: ${widget.appointment.appointmentDate}'),
              _buildDetailText('Status: ${widget.appointment.status}'),
              if (widget.appointment.notes != null) _buildDetailText('Notes: ${widget.appointment.notes!}'),
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





