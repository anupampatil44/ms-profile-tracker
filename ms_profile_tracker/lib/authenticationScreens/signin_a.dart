// ignore_for_file: unused_import, prefer_const_constructors, unused_element

import 'dart:convert';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ms_profile_tracker/authenticationScreens/authservices.dart';
import 'package:ms_profile_tracker/authenticationScreens/signup_a.dart';
import 'package:ms_profile_tracker/pages/alumni_dashboard.dart';

class SigninA extends StatefulWidget {
  const SigninA({Key? key}) : super(key: key);

  @override
  _SigninAState createState() => _SigninAState();
}

class _SigninAState extends State<SigninA> {
  bool isLoading = false;
  final key = GlobalKey<FormState>();

  var usernameC = TextEditingController();
  var emailC = TextEditingController();
  var passwordC = TextEditingController();

  String username = "";
  String email = "";
  String password = "";
  AuthServices auth = AuthServices();
  var storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    
    var size=MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in as Alumni"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: DelayedDisplay(
          delay: Duration(seconds: 1),
          child: Center(
            child: Form(
              key: key,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15,size.height*0.1,15,0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          //color: Colors.white,
                          border: Border.all(
                              color: Colors.grey, // set border color
                              width: 3.0), // set border width
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)), // set rounded corner radius
                        ),
                        child: TextFormField(
                          controller: usernameC,
                          decoration: InputDecoration(
                            label: Text("Username",textAlign: TextAlign.center,),
                            border: InputBorder.none,
                            icon: Icon(Icons.person),
                          ),
                          validator: (val) {
                            if (val == "") return "This Field Cannot Be empty";
                            return null;
                          },
                          onChanged: (val) {
                            setState() {
                              username = val;
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey, // set border color
                              width: 3.0), // set border width
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)), // set rounded corner radius
                        ),
                        child: TextFormField(
                          controller: passwordC,
                          decoration: InputDecoration(
                            label: Text("Password"),
                            icon: Icon(Icons.vpn_key),
                            border: InputBorder.none,
                          ),
                          validator: (val) {
                            if (val == "") return "This Field cannot be empty";
                            return null;
                          },
                          onChanged: (val) {
                            setState() {
                              password = val;
                            }
                          },
                          obscureText: true,
                        ),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (key.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            Map<String, String> data = {
                              "username": usernameC.text,
                              "password": passwordC.text,
                            };
                            var responseLogin =
                                await auth.post('/alumni/login', data);
                            if (responseLogin.statusCode == 200 ||
                                responseLogin.statusCode == 2) {
                              Map<String, dynamic> output =
                                  json.decode(responseLogin.body);
                              await storage.write(
                                  key: "token", value: output["token"]);
                              await storage.write(key: "userType", value: "alumni");
                              await storage.write(
                                  key: "username", value: data["username"]);
                              await storage.write(
                                  key: "password", value: data["password"]);
                              Fluttertoast.showToast(msg: "Signed In");
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => HomeA(
                                            username: usernameC.text,
                                            password: passwordC.text,
                                          )));
                            } else if (responseLogin.statusCode == 403) {
                              setState(() {
                                isLoading = false;
                              });
                              Fluttertoast.showToast(
                                  msg:
                                      "Incorrect username or password!\nPlease Try Again");
                            }
                          }
                        },
                        child: isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text("Signin"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("New User?"),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (ctx) => SignupA()));
                          },
                          child: Text(
                            "Register here",
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
