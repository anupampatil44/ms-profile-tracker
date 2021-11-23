// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ms_profile_tracker/user_models/alumni.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class AlumniProfile extends StatefulWidget {
  Alumni alumni;
  AlumniProfile(this.alumni);

  //const AlumniProfile({ Key? key }) : super(key: key);

  @override
  _AlumniProfileState createState() => _AlumniProfileState();
}

class _AlumniProfileState extends State<AlumniProfile> {
  void Launch(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not Launch $url';
  }

  @override
  Widget build(BuildContext context) {
    //List<dynamic> internships = widget.alumni.internships;
    PageController pageController = PageController();
    var pageController2 = PageController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Alumni's Profile"),
      ),
      body: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                radius: 50,
                child: Text(
                  widget.alumni.fullname[0].toUpperCase(),
                  style: TextStyle(fontSize: 45, color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 1, 0, 5),
            child: ListTile(
              //leading: Text("Name :"),
              title: Center(
                  child: Text(
                widget.alumni.fullname,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              )),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Email -"),
                    Text(widget.alumni.email,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("UG Department -"),
                    Text(widget.alumni.ugDept,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("UG Completion Year -"),
                    Text(widget.alumni.ugYear,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Text("University Details - "),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Card(
              child: ListTile(
                title: Text((widget.alumni.university != {})
                    ? widget.alumni.university["name"]
                    : ""),
                subtitle: Text((widget.alumni.university != {})
                    ? widget.alumni.university["location"]
                    : ""),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Text("PG Course Details - "),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Card(
              child: ListTile(
                title: Text((widget.alumni.pgCourse != {})
                    ? widget.alumni.pgCourse["name"]
                    : ""),
                subtitle: Text((widget.alumni.pgCourse != {})
                    ? widget.alumni.pgCourse["duration"]
                    : ""),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("PG Completion Year -"),
                    Text(widget.alumni.pgYear,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("City -"),
                    Text(widget.alumni.city,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Company -"),
                    Text(widget.alumni.company,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),

          //NetworkImage("https://img.icons8.com/ios-glyphs/50/000000/linkedin-circled--v1.png"),

          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                    leading: Image.asset("assets/linkedin.png"),
                    title: Text("LinkedIn"),
                    onTap: () async {
                      if (await canLaunch(widget.alumni.linkedIN)) {
                        await launch(widget.alumni.linkedIN,
                            forceWebView: false);
                      } else {
                        Fluttertoast.showToast(msg: "Cannot launch the url");
                        throw 'Could not launch ${widget.alumni.linkedIN}';
                      }
                    }
                    //Launch(widget.alumni.linkedIN);

                    ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Text("Internships - "),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: (widget.alumni.internships.isNotEmpty)
                ? ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: [
                      Container(
                        height: 100,
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: widget.alumni.internships.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            //print(internships[index]);
                            return Container(
                              padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                              child: Card(
                                  child: ListTile(
                                title: Text((widget.alumni.internships[index] !=
                                        {})
                                    ? widget.alumni.internships[index]["name"]
                                    : ""),
                                subtitle: Text(
                                    (widget.alumni.internships[index] != {})
                                        ? widget.alumni.internships[index]
                                            ["duration"]
                                        : ""),
                              )),
                            );
                          },
                        ),
                      ),
                      Container(
                        child: Center(
                          child: SmoothPageIndicator(
                            controller: pageController,
                            count: widget.alumni.internships.length,
                            effect: ScrollingDotsEffect(dotHeight: 1),
                          ),
                        ),
                      ),
                    ],
                  )
                : Text("No Data Available"),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Text("Scholarships - "),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: (widget.alumni.scholarships.isNotEmpty)
                ? ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: [
                      Container(
                        height: 100,
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: widget.alumni.scholarships.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            //print(internships[index]);
                            return Container(
                              padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                              child: Card(
                                  child: ListTile(
                                title: Text(
                                    (widget.alumni.scholarships[index] != {})
                                        ? widget.alumni.scholarships[index]
                                            ["name"]
                                        : ""),
                                subtitle: Text(
                                    (widget.alumni.scholarships[index] != {})
                                        ? widget.alumni.scholarships[index]
                                            ["description"]
                                        : ""),
                              )),
                            );
                          },
                        ),
                      ),
                      Container(
                        child: Center(
                          child: SmoothPageIndicator(
                            controller: pageController,
                            count: widget.alumni.internships.length,
                            effect: ScrollingDotsEffect(dotHeight: 1),
                          ),
                        ),
                      ),
                    ],
                  )
                : Text("No Data Available"),
          )
        ],
      ),
    );
  }
}
