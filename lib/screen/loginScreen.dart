import 'package:flutter/material.dart';
import 'package:kk/Helps/Utility.dart';
import 'dart:convert';
import 'package:kk/backend-integration/auth.dart';
import 'package:kk/backend-integration/global.dart';
import 'package:http/http.dart' as http;
import 'package:kk/screen/RegScreen.dart';
import 'package:kk/screen/HomeScreen.dart';
import 'package:kk/screen/Recp.dart';
import 'package:kk/screen/DoctorScreen.dart';




class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}

class Login extends StatelessWidget {
  String email = '';
  String password = '';
  String ? designation='';
  String name ='';

   void loginPressed(BuildContext context) async {
    if (email.isNotEmpty && password.isNotEmpty && designation != null) {
      try {
        http.Response response = await AuthServices.login(email, password, designation!, name);
        if (response.statusCode == 200) {
          Map<String, dynamic> responseMap = jsonDecode(response.body);
          if (responseMap.containsKey('user') && responseMap['user'] != null && responseMap['user'].containsKey('name')) {
            name = responseMap['user']['name'];
            print(name);

            if (designation == 'Doctor') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => DoctorScreen(doctorName: name),
                ),
              );
            } else if (designation == 'Reception') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ReceptionistPanel(),
                ),
              );
            } else {
              errorSnackBar(context, 'Invalid designation');
            }
          } else {
            print('Response body: ${response.body}');
            errorSnackBar(context, 'User data not found in response');
          }
        } else {
          Map<String, dynamic> errorMap = jsonDecode(response.body);
          errorSnackBar(context, errorMap['message']);
        }
      } catch (e) {
        print('Error: $e');
        errorSnackBar(context, 'An error occurred while processing your request');
      }
    } else {
      errorSnackBar(context, 'Enter all required fields');
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: customAppbar(),
     // drawer: customDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CuSiz(width: 200.0, height: 200.0, image: 'images/logo.png'),
             // const SizedBox(height: 5.0),        
              GenericSizedBox(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icons.email,
                onChanged: (value){
                  email = value;
                },
              ),
              GenericSizedBox(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: Icons.lock,
                onChanged: (value){
                  password = value;
                },
              ),
            //  const SizedBox(height: 5.0),
                            SizedBox(
                height: 70.0,
                width: 500.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    items: const [
                      DropdownMenuItem(
                        child: Text('Doctor'),
                        value: 'Doctor',
                      ),
                      DropdownMenuItem(
                        child: Text('Reception'),
                        value: 'Reception',
                      ),
                      /*
                      DropdownMenuItem(
                        child: Text('Admin'),
                        value: 'Admin',
                      ),*/
                    ],
                    onChanged: (value) {
                      designation = value ?? ''; 
                      print(designation);
                    },
                    decoration: InputDecoration(
                      labelText: 'Designation',
                      hintText: 'Select your Designation',
                      prefixIcon: Icon(Icons.design_services),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 200.0,
                height: 50.0,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegPage()),
                    );
                  },
                  child: Text("Sign Up", style: TextStyle(color: Colors.black)),
                ),
              ),
              //const SizedBox(height: 5.0),
              SizedBox(
                height: 100.0,
                width: 200.0, 
                child: CustomElevatedButton2(
                  label: 'Login',
                  color: Color.fromARGB(255, 7, 133, 237),
                  onPressed: () => loginPressed(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
