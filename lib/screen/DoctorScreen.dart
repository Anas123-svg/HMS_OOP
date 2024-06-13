import 'package:flutter/material.dart';
import 'package:kk/screen/HomeScreen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:kk/screen/PatientScreen.dart';
import 'dart:convert';

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
      admitted: json['admitted'] != null ? int.parse(json['admitted'].toString()) : 0,
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

Future<List<Appointment>> fetchAppointments() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/appointments2'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Appointment.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load appointments');
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
  final String doctorName;

  const DoctorScreen({Key? key, required this.doctorName}) : super(key: key);

  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  late Future<List<InOutPatientData>> inPatientsData;
  late Future<List<InOutPatientData>> outPatientsData;
  late Future<List<InOutPatientData>> patientCountsData;
  late Future<List<Appointment>> appointmentsData;
  int inP = 0;
  int outP = 0;
  int totalP = 0;

  @override
  void initState() {
    super.initState();
    inPatientsData = fetchInPatients();
    outPatientsData = fetchOutPatients();
    patientCountsData = fetchPatientCountsByDay();
    appointmentsData = fetchAppointments();
    fetchAllData(); 
  }


  Future<void> fetchAllData() async {
    final inPatients = await fetchInPatients();
    final outPatients = await fetchOutPatients();
    setState(() {
      inP = inPatients.length;
      outP = outPatients.length;
      totalP = inP + outP;
    });
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
      totalP = item.inPatientsCount + item.outPatientsCount;

      dayDataMap[item.day] = BarChartGroupData(
        x: daysOfWeek.indexOf(item.day),
        barRods: [
          BarChartRodData(y: inPatientsCount.toDouble(), colors: [Colors.blue], width: 20, borderRadius: BorderRadius.zero),
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
            CustomSidePanel(doctorName: widget.doctorName),
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              widget.doctorName,
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ContainerForDoctorPanel(
                              label: 'In Patients:',
                              value: inP.toString(),
                              color: Color.fromARGB(255, 7, 133, 237),
                              iconData: Icons.people,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: ContainerForDoctorPanel(
                              label: 'Out Patients:',
                              value: outP.toString(),
                              color: Color.fromARGB(255, 7, 133, 237),
                              iconData: Icons.people,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: ContainerForDoctorPanel(
                              label: 'Total Patients:',
                              value: totalP.toString(),
                              color: Color.fromARGB(255, 7, 133, 237),
                              iconData: Icons.people,
                            ),
                          ),
                        ],
                      ),
                                            Container(
                                               width: double.infinity,
                                              child: Card(
                                                                    elevation: 5,
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(12),
                                                                    ),
                                                                    child: Padding(
                                                                      padding: EdgeInsets.all(16.0),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            'Instructions',
                                                                            style: TextStyle(
                                                                              fontSize: 24,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                          SizedBox(height: 8),
                                                                          Text(
                                                                            "1. Use the side panel to navigate through different sections.\n"
                                                                            "2. The dashboard provides an overview of in-patients, out-patients, and total patients.\n"
                                                                            "3. View detailed consultations and appointments below.\n"
                                                                            "4. Use the calendar to keep track of upcoming appointments.\n"
                                                                            "5. For any assistance, contact the support team.",
                                                                            style: TextStyle(fontSize: 16),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                            ),
                      SizedBox(height: 16),
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
                                } else if (snapshot.hasError) {
                                  return Center(child: Text('Error: ${snapshot.error}'));
                                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                  return Center(child: Text('No patient counts data found'));
                                }
                                List<InOutPatientData> admittedPatients =
                                    snapshot.data!.where((patient) => patient.outPatientsCount >= 1).toList();
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
                                                barGroups: generateBarGroups(admittedPatients),
                                                borderData: FlBorderData(show: true),
                                                titlesData: FlTitlesData(
                                                  leftTitles: SideTitles(showTitles: true),
                                                  bottomTitles: SideTitles(
                                                    showTitles: true,
                                                    getTitles: (value) {
                                                      List<String> daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
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
                          SizedBox(width: 16),
                          Expanded(
                            child: FutureBuilder<List<InOutPatientData>>(
                              future: patientCountsData,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(child: Text('Error: ${snapshot.error}'));
                                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                  return Center(child: Text('No patient counts data found'));
                                }
                                List<InOutPatientData> admittedPatients =
                                    snapshot.data!.where((patient) => patient.inPatientsCount >= 1).toList();
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
                                                      List<String> daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
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
                            child: FutureBuilder<List<Appointment>>(
                              future: appointmentsData,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(child: Text('Error: ${snapshot.error}'));
                                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                  return Center(child: Text('No appointments found'));
                                }
                                return Card(
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
                                                rows: snapshot.data!.map((appointment) {
                                                  return DataRow(cells: [
                                                    DataCell(Text(appointment.appointmentDate.toLocal().toString().split(' ')[0])),
                                                    DataCell(Text(appointment.patient.name)),
                                                    DataCell(Text(TimeOfDay.fromDateTime(appointment.appointmentDate).format(context))),
                                                    DataCell(Text(appointment.doctor.name)),
                                                  ]);
                                                }).toList(),
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


class ContainerForDoctorPanel extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData iconData;

  const ContainerForDoctorPanel({
    Key? key,
    required this.label,
    required this.value,
    required this.color,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 40, color: color),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
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