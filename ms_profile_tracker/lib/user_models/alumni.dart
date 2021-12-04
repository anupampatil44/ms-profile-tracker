// ignore_for_file: unnecessary_this, non_constant_identifier_names

import 'package:mongo_dart/mongo_dart.dart';

class Alumni{

  ObjectId? id;

  String fullname="",username="",password="",email="",ugDept="",ugYear="",pgYear="",company="",city="",linkedIN="";
  Map<String,dynamic> pgCourse={};
  Map<String,dynamic> university={};
  Map<String,dynamic> qualificationExam={};
  List<dynamic> internships=[];
  List<dynamic> scholarships=[];
  
  /*
  {
    _id: ObjectId("619d24fc471264adc1ea01bc"), 
    username: MehulP, 
    password: 1234, 
    fullname: Mehul Patil, 
    email: mehulpatil@gmail.com, 
    linkedIN: , 
    city: Munich, 
    company: Amazon, 
    ugDept: Computer Engineering, 
    ugYear: 2021, 
    pgYear: 2023, 
    pgCourse: {name: MS (CS), duration: 2 years}, 
    university: {name: UT Austin, location: Texas}, 
    internships: [{name: Barclays, duration: 6 months}], 
    scholarships: [], 
    qualificationExam: {}
  }
  */
  Alumni.fromJson(Map data){
    this.id=data["_id"];
    this.username=data["username"];
    this.password=data["password"];
    this.fullname=data["fullname"];
    this.email=data["email"];
    this.ugDept=data["ugDept"];
    this.pgYear=data["pgYear"];
    this.ugYear=data["ugYear"];
    this.city=data["city"];
    this.company=data["company"];
    this.linkedIN=data["linkedIN"];
    this.pgCourse=data["pgCourse"];
    this.qualificationExam=data["qualificationExam"];
    this.internships=data["internships"];
    this.scholarships=data["scholarships"];
    this.university=data["university"];
  }

  Map<String,dynamic> toMap(){
    return {
      "_id":this.id,
      "username":this.username,
      "password":this.password,
      "fullname":this.fullname,
      "email":this.email,
      "linkedIN":this.linkedIN,
      "city":this.city,
      "company":this.company,
      "ugDept":this.ugDept,
      "ugYear":this.ugYear,
      "pgYear":this.pgYear,
      "qualificationExam":this.qualificationExam,
      "pgCourse":this.pgCourse,
      "university":this.university,
      "internships":this.internships,
      "scholarships":this.scholarships
    };
  }
}