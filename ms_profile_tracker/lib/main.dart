// ignore_for_file: unused_import, prefer_const_constructors, curly_braces_in_flow_control_structures, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ms_profile_tracker/authenticationScreens/signin_a.dart';
import 'package:ms_profile_tracker/authenticationScreens/signin_s.dart';
import 'package:ms_profile_tracker/database_services/database_api.dart';
import 'package:ms_profile_tracker/pages/alumni_dashboard.dart';
import 'package:ms_profile_tracker/pages/student_dashboard.dart';
import 'package:delayed_display/delayed_display.dart';
void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  

  
  Fluttertoast.showToast(msg: "Establishing Connection");
  await MongoDB.connect();
  Fluttertoast.showToast(msg: "Connection Established");
  print("Connection to MongoDB Established");
  final storage = FlutterSecureStorage();
  Map data=await storage.readAll();
  String? userType=data["userType"];
  String? token=data["token"];
  print(data);
  Widget Start(){
    if(userType=="alumni" && token!=null){
      return HomeA(username:data["username"],password:data["password"]);
    }
    else if(userType=="student" && token!=null){
      return HomeS(username:data["username"],password:data["password"]);
    }
    else return MSPT();
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) =>runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      fontFamily: "Raleway",
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      fontFamily: "Raleway",
    ),
    themeMode: ThemeMode.system,
    home: Start(),
  )
  ));
}

class MSPT extends StatelessWidget {
  const MSPT({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DelayedDisplay(
          delay: Duration(seconds: 1),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("MS Profiles \n   Tracker",style: TextStyle(fontSize: 40,fontFamily: "Raleway"),),
              SizedBox(height: 30,),
              Image.asset('assets/pict_logo.jpeg'),
              SizedBox(height: 15,),
              Text("Continue as -",style: TextStyle(fontSize: 25)),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>SigninS()));
                    }, 
                    child: Text("Student"),
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>SigninA()));
                    }, 
                    child: Text("Alumni"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}