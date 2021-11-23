// ignore_for_file: unused_import, prefer_const_constructors, use_key_in_widget_constructors

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ms_profile_tracker/authenticationScreens/authservices.dart';
import 'package:ms_profile_tracker/database_services/database_api.dart';
import 'package:ms_profile_tracker/main.dart';
import 'package:ms_profile_tracker/pages/alumni_profile.dart';
import 'package:ms_profile_tracker/pages/search.dart';
import 'package:ms_profile_tracker/user_models/alumni.dart';

class HomeS extends StatefulWidget {
  String? username, password;

  HomeS({this.username, this.password});
  //const HomeS({ Key? key }) : super(key: key);

  @override
  _HomeSState createState() => _HomeSState();
}

class _HomeSState extends State<HomeS> {
  var storage = FlutterSecureStorage();
  AuthServices auth = AuthServices();

  @override
  
  Widget build(BuildContext context) {
    
    refresh(){
      setState(() {
      });
      print("refreshed");
      //Fluttertoast.showToast(msg: "Refreshed");
    }
    
    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome, ${widget.username}"),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {});
                Fluttertoast.showToast(msg: "Refreshed");
              },
            ),
            IconButton(
                onPressed: () async {
                  await auth.logout(context);
                },
                icon: Icon(Icons.logout))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => Search()));
          },
          child: Icon(Icons.search,color: Colors.white,),
        ),
        body: FutureBuilder(
          future: MongoDB.getDocuments(),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              try{
              List<Map<String, dynamic>> l = snapshot.data;
              //print(l);
              if(l.isNotEmpty){
                return DelayedDisplay(
                  delay: Duration(seconds: 1),
                  child: ListView.builder(
                    itemCount: l.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      Alumni a = Alumni.fromJson(l[index]);
                      return Card(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: ListTile(
                            leading: Icon(Icons.school),
                            title: Text(a.fullname.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Padding(
                              padding: EdgeInsets.fromLTRB(0,5,0,0),
                              child: Text((a.pgCourse!={}) ? a.pgCourse["name"]+"\n"+((a.university!={}) ? a.university["name"] : "") : ""),
                            ),
                            //trailing: Text((a.university!={}) ? a.university["name"] : ""),,
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AlumniProfile(a)));
                            },
                          ),
                        ),
                      );
                    }),
                );
                }
                else{
                  return Center(
                    child: Text("No Data Found :)"),
                  );
                }
              }
              catch(e){
                return Center(child: Text("An Error Occurred"));
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
