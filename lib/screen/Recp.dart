import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kk/screen/loginScreen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:kk/screen/HomeScreen.dart';
import 'package:kk/screen/PatientScreen.dart';
import 'package:intl/intl.dart';
import 'dart:convert';


class CustomSidePanel2 extends StatelessWidget {
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
                    'Receptionist Panel',
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
                  MaterialPageRoute(builder: (context) => ReceptionistPanel()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.people, color: Colors.white),
              title: Text('patients', style: TextStyle(color: Colors.white)),
              onTap: () {
                                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Patients(doctorName: "dd",)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.white),
              title: Text('Appointments', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => noOfAppointments()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add, color: Colors.white),
              title: Text('add Appointments', style: TextStyle(color: Colors.white)),
              onTap: () {
                                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppointmentForm()),
                );
              },
            ),
                        ListTile(
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text('Logout', style: TextStyle(color: Colors.white)),
              onTap: () {
                                Navigator.push(
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
class ReceptionistPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receptionist Panel'),
      ),
      body: Row(
        children: [
          CustomSidePanel2(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, Receptionist Name',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Here you can manage appointments, view doctor schedules, '
                          'and see the number of patients. Use the buttons below to navigate '
                          'to the respective sections.'
                          'Here you can manage appointments, view doctor schedules, '
                          'and see the number of patients. Use the buttons below to navigate '
                          'to the respective sections.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AppointmentForm(),
                              ),
                            );
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, size: 50, color: Colors.white),
                                SizedBox(height: 10),
                                Text('Create Appointment', style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.schedule, size: 50, color: Colors.white),
                                SizedBox(height: 10),
                                Text('Doctor\'s Schedule', style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                                                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => noOfAppointments(),
                              ),
                            );
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_today, size: 50, color: Colors.white),
                                SizedBox(height: 10),
                                Text('No of Appointments', style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                                                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Patients(doctorName: "Receptionist",),
                              ),
                            );
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.people, size: 50, color: Colors.white),
                                SizedBox(height: 10),
                                Text('Number of Patients', style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: TableCalendar(
                                firstDay: DateTime.utc(2020, 10, 16),
                                lastDay: DateTime.utc(2030, 3, 14),
                                focusedDay: DateTime.now(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Important Instructions',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '1. Ensure all patient information is accurately recorded.\n'
                                    '2. Double-check appointment dates and times.\n'
                                    '3. Maintain patient confidentiality at all times.\n'
                                    '4. Update doctor schedules regularly.\n'
                                                                        '1. Ensure all patient information is accurately recorded.\n'
                                    '5. Double-check appointment dates and times.\n'
                                    '6. Maintain patient confidentiality at all times.\n'
                                    '7. Update doctor schedules regularly.\n'
                                                                        '1. Ensure all patient information is accurately recorded.\n'
                                    '8. Double-check appointment dates and times.\n'
                                    '9. Maintain patient confidentiality at all times.\n'
                                    '10. Update doctor schedules regularly.\n'
                                    '11. Provide patients with clear instructions for their visits.'
                                                                        '12. Maintain patient confidentiality at all times.\n'
                                    '13. Update doctor schedules regularly.\n'
                                    '14. Update doctor schedules regularly.\n'
                                    ,
                                    style: TextStyle(fontSize: 16),
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

class noOfAppointments extends StatefulWidget {
  @override
  _noOfAppointments createState() => _noOfAppointments();
}

class _noOfAppointments extends State<noOfAppointments> {
  late Future<Map<String, dynamic>> appointmentData;
  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    appointmentData = fetchAppointments(selectedFilter);
  }

  Future<Map<String, dynamic>> fetchAppointments(String selectedFilter) async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/appointments2'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        List<Appointment> appointments = jsonResponse.map<Appointment>((json) => Appointment.fromJson(json)).toList();

        if (selectedFilter == 'Visited') {
          appointments = appointments.where((appointment) => appointment.status == 'Visited').toList();
        } else if (selectedFilter == 'scheduled') {
          appointments = appointments.where((appointment) => appointment.status == 'scheduled').toList();
        }

        int totalAppointments = appointments.length;
        int visitedAppointments = appointments.where((appointment) => appointment.status == 'Visited').length;
        int unvisitedAppointments = totalAppointments - visitedAppointments;

        return {
          'appointments': appointments,
          'total': totalAppointments,
          'visited': visitedAppointments,
          'unvisited': unvisitedAppointments
        };
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
            CustomSidePanel2(),
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: appointmentData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Appointment> appointments = snapshot.data!['appointments'];
                    int totalAppointments = snapshot.data!['total'];
                    int visitedAppointments = snapshot.data!['visited'];
                    int unvisitedAppointments = snapshot.data!['unvisited'];

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
                                  'List of Appointments',
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
                                      appointmentData = fetchAppointments(selectedFilter);
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
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Total Appointments: $totalAppointments'),
                                Text('Visited: $visitedAppointments'),
                                Text('Unvisited: $unvisitedAppointments'),
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
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (BuildContext context) => AppointmentDetails(appointment: _appointment),
                                  //   ),
                                  // );
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



// Appointment Form Screen



class AppointmentForm extends StatefulWidget {
  @override
  _AppointmentFormState createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _patientIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _diagnosisController = TextEditingController();
  final TextEditingController _bedNumberController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  bool _admitted = false;
  DateTime _selectedDate = DateTime.now();

  late Future<List<Doctor>> _doctorList;
  Doctor? _selectedDoctor;

  @override
  void initState() {
    super.initState();
    _doctorList = _fetchDoctors();
  }

  Future<List<Doctor>> _fetchDoctors() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/doctors'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map<Doctor>((data) => Doctor.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        final doctorId = _selectedDoctor!.id;

        final dateFormat = DateFormat('yyyy-MM-dd');
        final appointmentDate = dateFormat.format(_selectedDate);

        final response = await http.post(
          Uri.parse('http://127.0.0.1:8000/api/appointments2_create'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'patient_id': _patientIdController.text,
            'name': _nameController.text, 
            'serialNumber': _serialNumberController.text,
            'diagnosis': _diagnosisController.text,
            'bedNumber': _bedNumberController.text,
            'condition': _conditionController.text,
            'admitted': _admitted ? 1 : 0,
            'date': dateFormat.format(DateTime.now()), // Assuming this is the patient's date field
            'notes': _notesController.text, 
            'doctor_id': doctorId,
            'appointment_date': appointmentDate,
            'status': 'scheduled', // Default status
          }),
        );

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Appointment created successfully')),
          );
        } else {
          print('Server response: ${response.body}');
          throw Exception('Failed to create appointment: ${response.body}');
        }
      } catch (error) {
        print('Error: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('MM/dd/yyyy').format(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              FutureBuilder<List<Doctor>>(
                future: _doctorList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Doctor> doctors = snapshot.data!;
                    return DropdownButtonFormField<Doctor>(
                      value: _selectedDoctor,
                      items: doctors.map((doctor) {
                        return DropdownMenuItem<Doctor>(
                          value: doctor,
                          child: Text(doctor.name),
                        );
                      }).toList(),
                      onChanged: (Doctor? doctor) {
                        setState(() {
                          _selectedDoctor = doctor;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Select Doctor'),
                      validator: (Doctor? value) {
                        if (value == null) {
                          return 'Please select a doctor';
                        }
                        return null;
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
              TextFormField(
                controller: _patientIdController,
                decoration: InputDecoration(labelText: 'Patient ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter patient ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter patient name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _serialNumberController,
                decoration: InputDecoration(labelText: 'Serial Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter serial number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _diagnosisController,
                decoration: InputDecoration(labelText: 'Diagnosis'),
              ),
              TextFormField(
                controller: _bedNumberController,
                decoration: InputDecoration(labelText: 'Bed Number'),
              ),
              TextFormField(
                controller: _conditionController,
                decoration: InputDecoration(labelText: 'Condition'),
              ),
              SwitchListTile(
                title: Text('Admitted'),
                value: _admitted,
                onChanged: (bool value) {
                  setState(() {
                    _admitted = value;
                  });
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Appointment Date',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(labelText: 'Notes'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Doctor model class
class Doctor {
  final int id;
  final String name;

  Doctor({required this.id, required this.name});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
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
            CustomSidePanel2(),
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
                                  /*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => PatientDetails(patient: patient),
                                    ),
                                  );*/
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
