// ignore_for_file: unused_import, prefer_const_constructors, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, unused_label

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ms_profile_tracker/authenticationScreens/authservices.dart';
import 'package:ms_profile_tracker/database_services/database_api.dart';
import 'package:ms_profile_tracker/main.dart';
import 'package:ms_profile_tracker/user_models/alumni.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeA extends StatefulWidget {
  String? username, password;

  HomeA({this.username, this.password});

  //const HomeA({ Key? key }) : super(key: key);

  @override
  _HomeAState createState() => _HomeAState();
}

class _HomeAState extends State<HomeA> {
  var storage = FlutterSecureStorage();

  AuthServices auth = AuthServices();

  var pageController = PageController();
  var pageController2 = PageController();



  @override
  Widget build(BuildContext context) {
    
  showSnackbar(){
    final snackbar=SnackBar(content: Text("Long press to edit"));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome, ${widget.username}"),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {});
                Fluttertoast.showToast(msg: "Refreshed");
              },
              icon: Icon(Icons.refresh),
            ),
            IconButton(
                onPressed: () async {
                  await auth.logout(context);
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: FutureBuilder(
          future: MongoDB.findOne(
              {"username": widget.username, "password": widget.password}),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print("Here");
              print(snapshot.data);
              try {
                Map data = snapshot.data;
                Alumni alumni = Alumni.fromJson(data);
                Map<String, dynamic> trial = alumni.toMap();
                //print(alumni.pgYear.runtimeType);
                //trial["company"]="FC Bayern Munich";
                //return Center (child:Text("Display the data in proper format"));
                return Center(
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            radius: 50,
                            child: Text(alumni.fullname[0].toUpperCase(),style: TextStyle(fontSize: 45,color: Colors.white),),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,1,0,5),
                        child: ListTile(
                          //leading: Text("Name :"),
                          title: Center(child: Text(alumni.fullname,style: TextStyle(fontWeight: FontWeight.bold,fontSize:25),)),
                          onTap: (){
                            showSnackbar();
                          },
                          onLongPress: (){
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  var nameC = TextEditingController();
                                  return AlertDialog(
                                    content: TextFormField(
                                      controller: nameC,
                                      decoration: InputDecoration(
                                        hintText: "Enter new name",
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            try {
                                              trial["fullname"] = nameC.text;
                                              await MongoDB.updateDoc(trial);
                                              Fluttertoast.showToast(
                                                  msg: "Updated");
                                              setState(() {});
                                              Navigator.pop(ctx);
                                            } catch (e) {
                                              Fluttertoast.showToast(
                                                  msg: "Error Occurred");
                                              Navigator.pop(ctx);
                                            }
                                          },
                                          child: Text("Update"))
                                    ],
                                  );
                                },
                              );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          //leading: Text("Name :"),
                          title: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Email :"),
                                Text(alumni.email),
                              ],
                            ),
                          ),
                          onTap: (){
                            showSnackbar();
                          },
                          onLongPress: (){
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  var emailC = TextEditingController();
                                  return AlertDialog(
                                    content: TextFormField(
                                      controller: emailC,
                                      decoration: InputDecoration(
                                        hintText: "Enter new email",
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            try {
                                              trial["email"] = emailC.text;
                                              await MongoDB.updateDoc(trial);
                                              Fluttertoast.showToast(
                                                  msg: "Updated");
                                              setState(() {});
                                              Navigator.pop(ctx);
                                            } catch (e) {
                                              Fluttertoast.showToast(
                                                  msg: "Error Occurred");
                                              Navigator.pop(ctx);
                                            }
                                          },
                                          child: Text("Update"))
                                    ],
                                  );
                                },
                              );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          //leading: Text("Name :"),
                          title: Padding(
                            padding: EdgeInsets.symmetric(horizontal:8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("UG Department :"),
                                Text(alumni.ugDept),
                              ],
                            ),
                          ),
                          onTap: (){
                            showSnackbar();
                          },
                          onLongPress: (){
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  var ugDeptC = TextEditingController();
                                  return AlertDialog(
                                    content: TextFormField(
                                      controller: ugDeptC,
                                      decoration: InputDecoration(
                                        hintText: "Enter UG Department",
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            try {
                                              trial["ugDept"] = ugDeptC.text;
                                              await MongoDB.updateDoc(trial);
                                              Fluttertoast.showToast(
                                                  msg: "Updated");
                                              setState(() {});
                                              Navigator.pop(ctx);
                                            } catch (e) {
                                              Fluttertoast.showToast(
                                                  msg: "Error Occurred");
                                              Navigator.pop(ctx);
                                            }
                                          },
                                          child: Text("Update"))
                                    ],
                                  );
                                },
                              );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          //leading: Text("Name :"),
                          title: Padding(
                            padding: EdgeInsets.symmetric(horizontal:8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("UG Completion Year :"),
                                Text(alumni.ugYear),
                              ],
                            ),
                          ),
                          onTap: (){
                            showSnackbar();
                          },
                          onLongPress: (){
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  var ugYearC = TextEditingController();
                                  return AlertDialog(
                                    content: TextFormField(
                                      controller: ugYearC,
                                      decoration: InputDecoration(
                                        hintText: "Enter UG Completion Year",
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            try {
                                              trial["ugYear"] = ugYearC.text;
                                              await MongoDB.updateDoc(trial);
                                              Fluttertoast.showToast(
                                                  msg: "Updated");
                                              setState(() {});
                                              Navigator.pop(ctx);
                                            } catch (e) {
                                              Fluttertoast.showToast(
                                                  msg: "Error Occurred");
                                              Navigator.pop(ctx);
                                            }
                                          },
                                          child: Text("Update"))
                                    ],
                                  );
                                },
                              );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          //leading: Text("Name :"),
                          title: Padding(
                            padding: EdgeInsets.symmetric(horizontal:8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("PG Completion Year :"),
                                Text(alumni.pgYear),
                              ],
                            ),
                          ),
                          onTap: (){
                            showSnackbar();
                          },
                          onLongPress: (){
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  var pgYearC = TextEditingController();
                                  return AlertDialog(
                                    content: TextFormField(
                                      controller: pgYearC,
                                      decoration: InputDecoration(
                                        hintText: "Enter PG Completion Year",
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            try {
                                              trial["pgYear"] = pgYearC.text;
                                              await MongoDB.updateDoc(trial);
                                              Fluttertoast.showToast(
                                                  msg: "Updated");
                                              setState(() {});
                                              Navigator.pop(ctx);
                                            } catch (e) {
                                              Fluttertoast.showToast(
                                                  msg: "Error Occurred");
                                              Navigator.pop(ctx);
                                            }
                                          },
                                          child: Text("Update"))
                                    ],
                                  );
                                },
                              );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:8),
                        child: Text("PG University Details-"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical:4),
                        child: ListTile(
                          //leading: Text("Name"),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Name: "),
                              Text((alumni.university!={}) ? alumni.university["name"] : ""),
                            ],
                          ),
                          subtitle: Text((alumni.university!={}) ? alumni.university["location"] : "",textAlign: TextAlign.right,),
                          onLongPress: (){
                            showDialog(
                                context: context, 
                                builder: (BuildContext ctx){
                                  var nameC=TextEditingController(),locC=TextEditingController();
                                  return AlertDialog(
                                    content: Container(
                                      height: 150,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            decoration : InputDecoration(
                                              label:Text("Enter University Name"),
                                            ),
                                            //initialValue: ((alumni.university!={}) ? alumni.university["name"] : ""),
                                            controller: nameC,
                                          ),
                                          TextFormField(
                                            decoration : InputDecoration(
                                              label:Text("Enter University Location"),
                                            ),
                                            //initialValue: ((alumni.university!={}) ? alumni.university["location"] : ""),
                                            controller: locC,
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: ()async{
                                          try{
                                            trial["university"]={"name":nameC.text,"location":locC.text};
                                            await MongoDB.updateDoc(trial);
                                            setState(() {
                                            });
                                            Fluttertoast.showToast(msg: "Updated");
                                            Navigator.pop(context);
                                          }
                                          catch(e){
                                            Fluttertoast.showToast(msg: "Error Occurred");
                                          }
                                        }, 
                                        child: Text("Update University Details")
                                      )
                                    ],
                                  );
                                }
                              );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:8),
                        child: Text("PG Course Details-"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical:4),
                        child: ListTile(
                          //leading: Text("Name"),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Name :"),
                              Text((alumni.pgCourse!={}) ? alumni.pgCourse["name"] : ""),
                            ],
                          ),
                          subtitle: Text((alumni.pgCourse!={}) ? alumni.pgCourse["duration"] : "",textAlign: TextAlign.right),
                          onTap: (){
                            showDialog(
                                context: context, 
                                builder: (BuildContext ctx){

                                  var nameC=TextEditingController(),durC=TextEditingController();
                                  return AlertDialog(
                                    content: Container(
                                      height: 150,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            decoration : InputDecoration(
                                              label:Text("Enter PG Course Name"),
                                            ),
                                            //initialValue: ((alumni.university!={}) ? alumni.university["name"] : ""),
                                            controller: nameC,
                                          ),
                                          TextFormField(
                                            decoration : InputDecoration(
                                              label:Text("Enter Course Duration"),
                                            ),
                                            //initialValue: ((alumni.university!={}) ? alumni.university["location"] : ""),
                                            controller: durC,
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: ()async{
                                          try{
                                            trial["pgCourse"]={"name":nameC.text,"duration":durC.text};
                                            await MongoDB.updateDoc(trial);
                                            setState(() {
                                            });
                                            Fluttertoast.showToast(msg:"Updated");
                                            Navigator.pop(context);
                                          }
                                          catch(e){
                                            Fluttertoast.showToast(msg:"Error Occurred");
                                          }
                                        }, 
                                        child: Text("Update PG Course Details")
                                      )
                                    ],
                                  );
                                }
                              );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          //leading: Text("Name :"),
                          title: Padding(
                            padding: EdgeInsets.symmetric(horizontal:8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Company Name :"),
                                Text(alumni.company),
                              ],
                            ),
                          ),
                          onTap: (){
                            showSnackbar();
                          },
                          onLongPress: (){
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  var companyC = TextEditingController();
                                  return AlertDialog(
                                    content: TextFormField(
                                      controller: companyC,
                                      decoration: InputDecoration(
                                        hintText: "Enter Company name",
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            try {
                                              trial["company"] = companyC.text;
                                              await MongoDB.updateDoc(trial);
                                              Fluttertoast.showToast(
                                                  msg: "Updated");
                                              setState(() {});
                                              Navigator.pop(ctx);
                                            } catch (e) {
                                              Fluttertoast.showToast(
                                                  msg: "Error Occurred");
                                              Navigator.pop(ctx);
                                            }
                                          },
                                          child: Text("Update"))
                                    ],
                                  );
                                },
                              );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          //leading: Text("Name :"),
                          title: Padding(
                            padding: EdgeInsets.symmetric(horizontal:8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("City :"),
                                Text(alumni.city),
                              ],
                            ),
                          ),
                          onTap: (){
                            showSnackbar();
                          },
                          onLongPress: (){
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  var cityC = TextEditingController();
                                  return AlertDialog(
                                    content: TextFormField(
                                      controller: cityC,
                                      decoration: InputDecoration(
                                        hintText: "City",
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            try {
                                              trial["city"] = cityC.text;
                                              await MongoDB.updateDoc(trial);
                                              Fluttertoast.showToast(
                                                  msg: "Updated");
                                              setState(() {});
                                              Navigator.pop(ctx);
                                            } catch (e) {
                                              Fluttertoast.showToast(
                                                  msg: "Error Occurred");
                                              Navigator.pop(ctx);
                                            }
                                          },
                                          child: Text("Update"))
                                    ],
                                  );
                                },
                              );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          //leading: Text("Name :"),
                          title: Padding(
                            padding: EdgeInsets.symmetric(horizontal:8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("LinkedIn :"),
                                Text(alumni.linkedIN),
                              ],
                            ),
                          ),
                          onTap: (){
                            showSnackbar();
                          },
                          onLongPress: (){
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  var linkedInC = TextEditingController();
                                  return AlertDialog(
                                    content: TextFormField(
                                      controller: linkedInC,
                                      decoration: InputDecoration(
                                        hintText: "LinkedIn",
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            try {
                                              trial["LinkedIN"] = linkedInC.text;
                                              await MongoDB.updateDoc(trial);
                                              Fluttertoast.showToast(
                                                  msg: "Updated");
                                              setState(() {});
                                              Navigator.pop(ctx);
                                            } catch (e) {
                                              Fluttertoast.showToast(
                                                  msg: "Error Occurred");
                                              Navigator.pop(ctx);
                                            }
                                          },
                                          child: Text("Update"))
                                    ],
                                  );
                                },
                              );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text("Internships- "),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext ctx) {
                                      var intNameC = TextEditingController();
                                      var intDurationC =
                                          TextEditingController();
                                      return AlertDialog(
                                        content: Container(
                                          height: 150,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                controller: intNameC,
                                                decoration: InputDecoration(
                                                  label: Text(
                                                      "Enter Internship Name"),
                                                ),
                                              ),
                                              TextFormField(
                                                controller: intDurationC,
                                                decoration: InputDecoration(
                                                  label: Text(
                                                      "Enter Internship Duration"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () async {
                                                try {
                                                  List l = trial["internships"];
                                                  l.add({
                                                    "name": intNameC.text,
                                                    "duration":
                                                        intDurationC.text
                                                  });
                                                  trial["internships"] = l;
                                                  await MongoDB.updateDoc(
                                                      trial);
                                                  setState(() {});
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Added Internship Details");
                                                  Navigator.pop(context);
                                                } catch (e) {
                                                  Fluttertoast.showToast(
                                                      msg: "Error Occurred");
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: Text(
                                                  "Add Internship Details"))
                                        ],
                                      );
                                    });
                              },
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: (alumni.internships.isNotEmpty)
                            ? ListView(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                children: [
                                  Container(
                                    height: 100,
                                    child: PageView.builder(
                                      controller: pageController,
                                      itemCount: alumni.internships.length,
                                      itemBuilder:
                                          (BuildContext ctx, int index) {
                                        var intNameC = TextEditingController();
                                        var intDurC = TextEditingController();
                                        return Container(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 10, 5, 10),
                                          child: Card(
                                              child: ListTile(
                                            //leading: Text("Name- "),
                                            title: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Name :"),
                                                Text(alumni
                                                    .internships[index]["name"],),
                                              ],
                                            ),
                                            subtitle: Text(
                                                alumni.internships[index]
                                                    ["duration"],textAlign: TextAlign.right),
                                            onTap: showSnackbar,
                                            onLongPress: (){
                                              showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext ctx) {
                                                      var intNameC =
                                                          TextEditingController();
                                                      var intDurationC =
                                                          TextEditingController();
                                                      return AlertDialog(
                                                        content: Container(
                                                          height: 150,
                                                          child: Column(
                                                            children: [
                                                              TextFormField(
                                                                controller:
                                                                    intNameC,
                                                                decoration:
                                                                    InputDecoration(
                                                                  label: Text(
                                                                      "Enter Internship Name"),
                                                                ),
                                                              ),
                                                              TextFormField(
                                                                controller:
                                                                    intDurationC,
                                                                decoration:
                                                                    InputDecoration(
                                                                  label: Text(
                                                                      "Enter Internship Duration"),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: [
                                                          ElevatedButton(
                                                            onPressed: () async{
                                                              try{
                                                                List l=trial["internships"];
                                                                l.removeAt(index);
                                                                trial["internships"]=l;
                                                                await MongoDB.updateDoc(trial);
                                                                Fluttertoast.showToast(msg: "Deleted the internship details");
                                                                setState(() {
                                                                });
                                                                Navigator.pop(context);
                                                              }
                                                              catch(e){
                                                                Fluttertoast.showToast(msg: "Error Occurred");
                                                                Navigator.pop(context);
                                                              }
                                                            }, 
                                                            child: Text("Delete")
                                                          ),
                                                          ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                try {
                                                                  trial["internships"][index]={"name":intNameC.text,"duration":intDurationC.text};
                                                                  await MongoDB
                                                                      .updateDoc(
                                                                          trial);
                                                                  setState(
                                                                      () {});
                                                                  Fluttertoast
                                                                      .showToast(
                                                                          msg:
                                                                              "Updated Internship Details");
                                                                  Navigator.pop(
                                                                      context);
                                                                } catch (e) {
                                                                  Fluttertoast
                                                                      .showToast(
                                                                          msg:
                                                                              "Error Occurred");
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              },
                                                              child: Text(
                                                                  "Update Internship Details"))
                                                        ],
                                                      );
                                                    });
                                            },
                                          )),
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    child: Center(
                                      child: SmoothPageIndicator(
                                        controller: pageController,
                                        count: alumni.internships.length,
                                        effect:
                                            ScrollingDotsEffect(dotHeight: 1),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Card(child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("No Data Available"),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text("Scholarships- "),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext ctx) {
                                      var intNameC = TextEditingController();
                                      var intDescriptionC =
                                          TextEditingController();
                                      return AlertDialog(
                                        content: Container(
                                          height: 150,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                controller: intNameC,
                                                decoration: InputDecoration(
                                                  label: Text(
                                                      "Enter Scholarship Name"),
                                                ),
                                              ),
                                              TextFormField(
                                                controller: intDescriptionC,
                                                decoration: InputDecoration(
                                                  label: Text(
                                                      "Enter Scholarship Description"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () async {
                                                try {
                                                  List l = trial["scholarships"];
                                                  l.add({
                                                    "name": intNameC.text,
                                                    "description":
                                                        intDescriptionC.text
                                                  });
                                                  trial["scholarships"] = l;
                                                  await MongoDB.updateDoc(
                                                      trial);
                                                  setState(() {});
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Added Scholarship Details");
                                                  Navigator.pop(context);
                                                } catch (e) {
                                                  Fluttertoast.showToast(
                                                      msg: "Error Occurred");
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: Text(
                                                  "Add Scholarship Details"))
                                        ],
                                      );
                                    });
                              },
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: (alumni.scholarships.isNotEmpty)
                            ? ListView(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                children: [
                                  Container(
                                    height: 100,
                                    child: PageView.builder(
                                      controller: pageController2,
                                      itemCount: alumni.scholarships.length,
                                      itemBuilder:
                                          (BuildContext ctx, int index) {
                                        var intNameC = TextEditingController();
                                        var intDescriptionC = TextEditingController();
                                        return Container(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 10, 5, 10),
                                          child: Card(
                                              child: ListTile(
                                            //leading: Text("Name- "),
                                            title: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Name :"),
                                                Text(alumni
                                                    .scholarships[index]["name"]),
                                              ],
                                            ),
                                            subtitle: Text(
                                                alumni.scholarships[index]
                                                    ["description"],textAlign: TextAlign.right),
                                            onLongPress: (){
                                              showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext ctx) {
                                                      var intNameC =
                                                          TextEditingController();
                                                      var intDescriptionC =
                                                          TextEditingController();
                                                      return AlertDialog(
                                                        content: Container(
                                                          height: 150,
                                                          child: Column(
                                                            children: [
                                                              TextFormField(
                                                                controller:
                                                                    intNameC,
                                                                decoration:
                                                                    InputDecoration(
                                                                  label: Text(
                                                                      "Enter Scholarship Name"),
                                                                ),
                                                              ),
                                                              TextFormField(
                                                                controller:
                                                                    intDescriptionC,
                                                                decoration:
                                                                    InputDecoration(
                                                                  label: Text(
                                                                      "Enter Scholarship Description"),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: [
                                                          ElevatedButton(
                                                            onPressed: () async{
                                                              try{
                                                                List l=trial["scholarships"];
                                                                l.removeAt(index);
                                                                trial["scholarships"]=l;
                                                                await MongoDB.updateDoc(trial);
                                                                Fluttertoast.showToast(msg: "Deleted the scholarship details");
                                                                setState(() {
                                                                });
                                                                Navigator.pop(context);
                                                              }
                                                              catch(e){
                                                                Fluttertoast.showToast(msg: "Error Occurred");
                                                                Navigator.pop(context);
                                                              }
                                                            }, 
                                                            child: Text("Delete")
                                                          ),
                                                          ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                try {
                                                                  trial["scholarships"][index]={"name":intNameC.text,"duration":intDescriptionC.text};
                                                                  await MongoDB
                                                                      .updateDoc(
                                                                          trial);
                                                                  setState(
                                                                      () {});
                                                                  Fluttertoast
                                                                      .showToast(
                                                                          msg:
                                                                              "Updated Scholarship Details");
                                                                  Navigator.pop(
                                                                      context);
                                                                } catch (e) {
                                                                  Fluttertoast
                                                                      .showToast(
                                                                          msg:
                                                                              "Error Occurred");
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              },
                                                              child: Text(
                                                                  "Update Scholarship Details"))
                                                        ],
                                                      );
                                                    });
                                            },
                                          )),
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    child: Center(
                                      child: SmoothPageIndicator(
                                        controller: pageController,
                                        count: alumni.scholarships.length,
                                        effect:
                                            ScrollingDotsEffect(dotHeight: 1),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Card(child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("No Data Available"),
                            )),
                      ),
                      SizedBox(height:10),
                    ],
                  ),
                );
              } catch (e) {
                print("Caught an error");
                return Center(
                  child: Text("Oops! An Error Occurred"),
                );
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