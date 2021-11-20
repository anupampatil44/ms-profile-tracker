// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ms_profile_tracker/user_models/alumni.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AlumniProfile extends StatefulWidget {
  
  Alumni alumni;
  AlumniProfile(this.alumni);
  
  //const AlumniProfile({ Key? key }) : super(key: key);



  @override
  _AlumniProfileState createState() => _AlumniProfileState();
}

class _AlumniProfileState extends State<AlumniProfile> {
  @override
  Widget build(BuildContext context) {

    List<dynamic>? internships = widget.alumni.internships;
    PageController pageController=PageController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Alumni's Profile"),
      ),
      body: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8,8,8,0),
            child: Card(
              child: Padding(
                padding:  EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Name -"),
                    Text((widget.alumni.name!=null) ? widget.alumni.name.toString() : "",style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8,8,8,0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Email -"),
                    Text((widget.alumni.email!=null) ? widget.alumni.email.toString() : "",style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8,8,8,0),
            child: Text("Internships - "),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: (internships.runtimeType!=Null) ? 
              ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  Container(
                    height: 100,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: internships!.length,
                      itemBuilder: (BuildContext ctx,int index){
                        print(internships[index]);
                        return Container(
                          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                          child: Card(
                            child: ListView(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:8.0),
                                  child: Text("Name: "+
                                    internships[index]["name"],
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:8.0),
                                  child: Text("Duration: "+
                                    internships[index]["duration"],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: internships.length,
                        effect: ScrollingDotsEffect(dotHeight: 1),
                      ),
                    ),
                  ),
                ],
              )
              : 
              Text("No Data Available"),
          )
        ],
      ),
    );
  }
}
