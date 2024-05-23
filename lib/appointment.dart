import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppointmentScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  List<Map<String, String>> patients = [
    
  ];

  void _addPatient(Map<String, String> newPatient) {
    setState(() {
      patients.add(newPatient);
    });
  }

  void _updatePatient(String id, Map<String, String> updatedPatient) {
    setState(() {
      final index = patients.indexWhere((patient) => patient['id'] == id);
      if (index != -1) {
        patients[index] = updatedPatient;
      }
    });
  }

  void _deletePatient(String id) {
    setState(() {
      patients.removeWhere((patient) => patient['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients List'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Dashboard'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Patients'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Appointments'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Lab Reports'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          return ListTile(
            leading: Checkbox(
              value: false,
              onChanged: (bool? value) {},
            ),
            title: Row(
              children: [
                Expanded(flex: 1, child: Text(patient['id']!)),
                Expanded(flex: 3, child: Text(patient['name']!)),
                Expanded(flex: 2, child: Text(patient['bedNo']!)),
                Expanded(flex: 3, child: Text(patient['diagnosis']!)),
                Expanded(
                  flex: 2,
                  child: Text(
                    patient['condition']!,
                    style: TextStyle(
                      color: patient['condition'] == 'Critical' ? Colors.red : Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PatientForm(
                        patient: patient,
                        onSave: (updatedPatient) => _updatePatient(patient['id']!, updatedPatient),
                      ),
                    ));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deletePatient(patient['id']!),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PatientForm(onSave: _addPatient),
          ));
        },
      ),
    );
  }
}

class PatientForm extends StatefulWidget {
  final Map<String, String>? patient;
  final void Function(Map<String, String> patient) onSave;

  PatientForm({this.patient, required this.onSave});

  @override
  _PatientFormState createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _bedNoController = TextEditingController();
  final _diagnosisController = TextEditingController();
  final _conditionController = TextEditingController();
  final _idCardController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.patient != null) {
      _idController.text = widget.patient!['id']!;
      _nameController.text = widget.patient!['name']!;
      _bedNoController.text = widget.patient!['bedNo']!;
      _diagnosisController.text = widget.patient!['diagnosis']!;
      _conditionController.text = widget.patient!['condition']!;
      _idCardController.text = widget.patient!['idCard']!;
      _phoneController.text = widget.patient!['phone']!;
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _bedNoController.dispose();
    _diagnosisController.dispose();
    _conditionController.dispose();
    _idCardController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newPatient = {
        'id': _idController.text,
        'name': _nameController.text,
        'bedNo': _bedNoController.text,
        'diagnosis': _diagnosisController.text,
        'condition': _conditionController.text,
        'idCard': _idCardController.text,
        'phone': _phoneController.text,
      };
      widget.onSave(newPatient);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.patient == null ? 'Add Patient' : 'Edit Patient'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bedNoController,
                decoration: InputDecoration(labelText: 'Bed No'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter bed number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _diagnosisController,
                decoration: InputDecoration(labelText: 'Diagnosis'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter diagnosis';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _conditionController,
                decoration: InputDecoration(labelText: 'Condition'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter condition';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _idCardController,
                decoration: InputDecoration(labelText: 'ID Card Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ID card number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text(widget.patient == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
