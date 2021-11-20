// ignore_for_file: unused_import, prefer_const_constructors, unused_element

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ms_profile_tracker/authenticationScreens/authservices.dart';
import 'package:ms_profile_tracker/authenticationScreens/signin_s.dart';
import 'package:ms_profile_tracker/pages/home_a.dart';
import 'package:ms_profile_tracker/pages/home_s.dart';

class SignupS extends StatefulWidget {
  const SignupS({ Key? key }) : super(key: key);

  @override
  _SignupSState createState() => _SignupSState();
}

class _SignupSState extends State<SignupS> {
  
    bool isLoading=false;
  final key=GlobalKey<FormState>();

  var usernameC=TextEditingController();
  var nameC=TextEditingController();
  var emailC=TextEditingController();
  var passwordC=TextEditingController();

  String username="";
  String email="";
  String password="";
  String name="";
  AuthServices auth=AuthServices();
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register as a Student"),
      ),
      body: Center(
        child: Form(
        key: key,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: usernameC,
                decoration: InputDecoration(
                  label: Text("Username"),
                  //hintText: "Enter username",
                  icon: Icon(Icons.person),
                ),
                validator: (val){
                  if(val=="") return "This Field Cannot Be empty";
                  return null;
                },
                onChanged: (val){
                  setState(){
                    username=val;               
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameC,
                decoration: InputDecoration(
                  label: Text("Name"),
                  //hintText: "Enter username",
                  //icon: Icon(Icons.),
                ),
                validator: (val){
                  if(val=="") return "This Field Cannot Be empty";
                  return null;
                },
                onChanged: (val){
                  setState(){
                    username=val;               
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailC,
                decoration: InputDecoration(
                  label: Text("Enter your email"),
                  icon: Icon(Icons.email),
                ),
                validator: (val){
                  // TODO :Add Email Validation
                  if(val=="") return "This Field Cannot Be empty";
                  return null;
                },
                onChanged: (val){
                  setState(){
                    email=val;               
                  }
                },
              ),
            ),
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passwordC,
                decoration: InputDecoration(
                  label: Text("Create a Password"),
                  icon: Icon(Icons.vpn_key),
                ),
                validator: (val){
                  if(val=="") return "This Field cannot be empty";
                  return null;
                },
                onChanged: (val){
                  setState(){
                    password=val;
                  }
                },
                obscureText: true,
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: ()async{
                  if (key.currentState!.validate()){
                    setState(() {
                      isLoading=true;
                    });
                    Map<String,String> data={
                      "username":usernameC.text,
                      "password":passwordC.text,
                      "email":emailC.text,
                      "name":nameC.text
                    };
                    print(data);
                    var responseRegister = await auth.post('/student/register', data);
                    if(responseRegister.statusCode==200 || responseRegister.statusCode==201){
                      Fluttertoast.showToast(msg: "Registered Successfully!");
                      Map<String,String> d={
                        "username":usernameC.text,
                        "password":passwordC.text
                      };
                      var responseLogin = await auth.post('/student/login', d);
                      if(responseLogin.statusCode==200 || responseLogin.statusCode==201){
                        Map<String,dynamic> output= json.decode(responseLogin.body);
                        await storage.write(key: "token", value: output["token"]);
                        await storage.write(key: "userType",value:"student");
                        await storage.write(key: "username", value: d["username"]);
                        await storage.write(key: "password", value: d["password"]);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>HomeS(username: d["username"],password: data["password"],)));
                      }
                      else if (responseLogin.statusCode==403){
                        setState(() {
                          isLoading=false;
                        });
                        Fluttertoast.showToast(msg: "Error Occured!\nPlease Try sign in.");
                      }
                    }
                    else if(responseRegister.statusCode==403){
                      setState(() {
                        isLoading=false;
                      });
                      Fluttertoast.showToast(msg: "Username Already Exists!\nTry using different username");
                    }
                  }           
                },
                child: isLoading ? CircularProgressIndicator(color: Colors.white,) : Text("Register"),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                InkWell(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>SigninS()));
                  },
                  child: Text(" Sign In here",style: TextStyle(color: Colors.blue)),
                )
              ],
            )
          ],
        ),
        ),
      ),
    );
  }
}