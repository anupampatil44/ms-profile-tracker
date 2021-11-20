// ignore_for_file: unused_import, prefer_const_constructors, prefer_is_empty



import 'package:flutter/material.dart';
import 'package:ms_profile_tracker/database_services/database_api.dart';
import 'package:ms_profile_tracker/pages/alumni_profile.dart';
import 'package:ms_profile_tracker/user_models/alumni.dart';

class Search extends StatefulWidget {
  const Search({ Key? key }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  
  List<Map<String,dynamic>> alumnis=[];
  var key=GlobalKey<FormState>();
  var sC=TextEditingController();
  String s="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Form(
          key: key,
          child: TextFormField(
            controller: sC,
            onChanged: (val){
              setState(() {
                s=val;   
              });
            },
            decoration: InputDecoration(
              label: Text("Search by Name or University or Course Name",style: TextStyle(fontSize: 15),),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: ()async{
              Map<String,dynamic> data= (sC.text=="") ? {} : {"universityName":sC.text,"name":sC.text,"pgCourse":sC.text};
              List<Map<String,dynamic>> l = await MongoDB.searchDocs(data);
              alumnis=List.castFrom(l);
              setState(() {
              });
            }, 
            icon: Icon(Icons.search)
          )
        ],
      ),
      body: (alumnis.length>0) ? ListView.builder(
        itemCount: alumnis.length,
        itemBuilder: (ctx,index){
          Alumni a=Alumni.fromJson(alumnis[index]);
          return Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              title: Text(a.username.toString()),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AlumniProfile(a)));
              },
            ),
          );
        } 
      ) :
      Center(
        child: Text("No Records Found"),
      )
    );
  }
}