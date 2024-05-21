import 'package:flutter/material.dart';
import 'package:kk/Helps/Utility.dart';
import 'dart:convert';
import 'package:kk/backend-integration/auth.dart';
import 'package:kk/backend-integration/global.dart';
import 'package:http/http.dart' as http;
import 'package:kk/screen/HomeScreen.dart';

class RegPage extends StatelessWidget {
  String email = '';
  String password = '';
  String name = '';
  String designation = '';

  void createAccountPressed(BuildContext context) async {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid) {
      try {
        http.Response response =
            await AuthServices.register(name, email, password, designation);
        if (response.statusCode == 201 && designation=='Doctor') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen(),
            ),
          );
        } else if (response.statusCode == 500) {
          errorSnackBar(context, 'Email already exists.');
        } else {
          Map<String, dynamic> responseMap = jsonDecode(response.body);
          errorSnackBar(context, responseMap['error'] ?? 'An error occurred.');
        }
      } catch (e) {
        errorSnackBar(context, 'An error occurred. Please try again.');
        print('Error: $e'); // For debugging purposes
      }
    } else {
      errorSnackBar(context, 'Email is not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CuSiz(width: 200.0, height: 200.0, image: 'images/logo.png'),
              const SizedBox(height: 10.0),
              GenericSizedBox(
                labelText: 'Name',
                hintText: 'Enter your name',
                prefixIcon: Icons.person,
                onChanged: (value) {
                  name = value;
                },
              ),
              GenericSizedBox(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icons.email,
                onChanged: (value) {
                  email = value;
                },
              ),
              GenericSizedBox(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: Icons.lock,
                onChanged: (value) {
                  password = value;
                },
              ),
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
                      DropdownMenuItem(
                        child: Text('Admin'),
                        value: 'Admin',
                      ),
                    ],
                    onChanged: (value) {
                      designation = value ?? ''; 
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
              const SizedBox(height: 10.0),
              SizedBox(
                height: 100.0,
                width: 200.0,
                child: CustomElevatedButton2(
                  label: 'Sign Up',
                  color: Color.fromARGB(255, 7, 133, 237),
                  onPressed: () => createAccountPressed(context),
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                height: 10.0,
                width: 200.0,
                child: Text("Email"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

