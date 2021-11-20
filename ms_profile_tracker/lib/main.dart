// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ms_profile_tracker/authenticationScreens/signin_a.dart';
import 'package:ms_profile_tracker/authenticationScreens/signin_s.dart';
import 'package:ms_profile_tracker/database_services/database_api.dart';
import 'package:ms_profile_tracker/pages/home_a.dart';
import 'package:ms_profile_tracker/pages/home_s.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDB.connect();
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
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Start(),
  )
  );
}

class MSPT extends StatelessWidget {
  const MSPT({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("MS Profiles Tracker",style: TextStyle(fontSize: 40),),
          SizedBox(height: 30,),
          Text("Continue as -",style: TextStyle(fontSize: 25)),
          SizedBox(height: 30,),
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
    );
  }
}