// ignore_for_file: unused_import, prefer_const_constructors, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, unused_label


import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ms_profile_tracker/authenticationScreens/authservices.dart';
import 'package:ms_profile_tracker/database_services/database_api.dart';
import 'package:ms_profile_tracker/main.dart';
import 'package:ms_profile_tracker/user_models/alumni.dart';

class HomeA extends StatefulWidget {
  
  String? username,password;
  
  HomeA({this.username,this.password});
  
  //const HomeA({ Key? key }) : super(key: key);

  @override
  _HomeAState createState() => _HomeAState();
}

class _HomeAState extends State<HomeA> {
  
  var storage=FlutterSecureStorage();

  AuthServices auth=AuthServices();

  late Alumni alumni;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("MS Profiles Tracker\nAlumni HomePage"),
        actions: [
          IconButton(
            onPressed: ()async{
              await auth.logout(context);
            },
            icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: (){
          setState(() {});
        },
      ),
      body: FutureBuilder(
        future: MongoDB.findOne({"username":widget.username,"password":widget.password}),
        builder: (BuildContext ctx,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            try{
              Map data=snapshot.data;
              alumni=Alumni.fromJson(data);
              Map<String,dynamic> trial=alumni.toMap();
              print(alumni.pgYear.runtimeType);
              //trial["company"]="FC Bayern Munich";
              //return Center (child:Text("Display the data in proper format"));
              return Center(
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Text("Name"),
                        title: Text((alumni.name.runtimeType!=Null) ? alumni.name! : ""),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: (){
                            showDialog(
                              context: context,
                              builder: (ctx){
                                var nameC=TextEditingController();
                                return AlertDialog(
                                  content: TextFormField(
                                    controller: nameC,
                                    decoration: InputDecoration(
                                      hintText: "Enter new name",
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: ()async{
                                        try{
                                        trial["name"]=nameC.text;
                                        await MongoDB.updateDoc(trial);
                                        Fluttertoast.showToast(msg: "Updated");
                                        setState(() {
                                        });
                                        Navigator.pop(ctx);
                                        }
                                        catch(e){
                                          Fluttertoast.showToast(msg: "Error Occurred");
                                          Navigator.pop(ctx);
                                        }
                                      },
                                      child: Text("Update")
                                    )
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            catch(e){
              return Center(
                child: Text("Oops! An Error Occurred"),);
            }
          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      )
    );
  }
}

