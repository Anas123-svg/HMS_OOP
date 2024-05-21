import 'dart:convert';

import 'package:http/http.dart' as http;

import 'global.dart';
class AuthServices{
  static Future<http.Response> register(
    String name, String email,String password, String designation)
  async{
    Map data= {
      'name': name,
      'email': email,
      'password': password,
      'designation': designation,
    };
    var body=json.encode(data);
    var url=Uri.parse(host_Url + 'auth/register');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    return response;
    }


    static Future<http.Response> login(String email, String password,String designation) async {
    Map data = {
      "email": email,
      "password": password,
      "designation": designation,
    };
    var body = json.encode(data);
    var url = Uri.parse(host_Url + 'auth/login');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    return response;
  }
}


