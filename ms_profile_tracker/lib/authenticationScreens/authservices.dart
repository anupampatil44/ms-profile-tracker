// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:ms_profile_tracker/main.dart';

class AuthServices {
  String baseurl = "https://ms-profiles-tracker.herokuapp.com";
  var log = Logger();
  FlutterSecureStorage storage = FlutterSecureStorage();

  String formater(String url) {
    return baseurl + url;
  }

  Future<void> logout(BuildContext context) async {
    await storage.deleteAll().then((value) { 
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => MSPT()));
      Fluttertoast.showToast(msg: "Logged Out");  
      });
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    String? token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }

  // Future<http.Response> patch(String url, Map<String, String> body) async {
  //   String? token = await storage.read(key: "token");
  //   url = formater(url);
  //   log.d(body);
  //   var response = await http.patch(
  //     Uri.parse(url),
  //     headers: {
  //       "Content-type": "application/json",
  //       "Authorization": "Bearer $token"
  //     },
  //     body: json.encode(body),
  //   );
  //   return response;
  // }

  // Future get(String url) async {
  //   String? token = await storage.read(key: "token");
  //   url = formater(url);
  //   // /user/register
  //   var response = await http.get(
  //     Uri.parse(url),
  //     headers: {"Authorization": "Bearer $token"},
  //   );
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     log.i(response.body);

  //     return json.decode(response.body);
  //   }
  //   log.i(response.body);
  //   log.i(response.statusCode);
  // }

  // Future<http.Response> post1(String url, var body) async {
  //   String? token = await storage.read(key: "token");
  //   url = formater(url);
  //   log.d(body);
  //   var response = await http.post(
  //     Uri.parse(url),
  //     headers: {
  //       "Content-type": "application/json",
  //       "Authorization": "Bearer $token"
  //     },
  //     body: json.encode(body),
  //   );
  //   return response;
  // }

  // Future<http.StreamedResponse> patchImage(String url, String filepath) async {
  //   url = formater(url);
  //   String? token = await storage.read(key: "token");
  //   var request = http.MultipartRequest('PATCH', Uri.parse(url));
  //   request.files.add(await http.MultipartFile.fromPath("img", filepath));
  //   request.headers.addAll({
  //     "Content-type": "multipart/form-data",
  //     "Authorization": "Bearer $token"
  //   });
  //   var response = request.send();
  //   return response;
  // }

  // NetworkImage getImage(String imageName) {
  //   String url = formater("/uploads//$imageName.jpg");
  //   return NetworkImage(url);
  // }
}


// AuthServices auth=AuthServices();

// Future<void> signUp(Map<String,String> data,String route) async {
    
//     var responseRegister = await auth.post('/student/register', data);
    
//     if (responseRegister.statusCode == 200 ||
//         responseRegister.statusCode == 201) {
//       Fluttertoast.showToast(msg: "Registered Successfully!");
//       Map<String, String> d = {
//         "username": data["username"],
//         "password": data["password"]
//       };
//       var responseLogin = await AuthServices.post('/student/login', d);
//       if (responseLogin.statusCode == 200 || responseLogin.statusCode == 201) {
//         Map<String, dynamic> output = json.decode(responseLogin.body);
//         await storage.write(key: "token", value: output["token"]);
//         await storage.write(key: "userType", value: "student");
//         await storage.write(key: "username", value: d["username"]);
//         await storage.write(key: "password", value: d["password"]);
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (ctx) => HomeS()));
//       } else if (responseLogin.statusCode == 403) {
//         setState(() {
//           isLoading = false;
//         });
//         Fluttertoast.showToast(msg: "Error Occured!\nPlease Try sign in.");
//       }
//     } else if (responseRegister.statusCode == 403) {
//       setState(() {
//         isLoading = false;
//       });
//       Fluttertoast.showToast(
//           msg: "Username Already Exists!\nTry using different username");
//     }
//   }