// ignore_for_file: unnecessary_this

import 'package:mongo_dart/mongo_dart.dart';

class Alumni{

  ObjectId? id;

  String? name,username,password,email,ugDept,ugYear,pgYear,company,city,linkedIn;
  Map<String,dynamic>? pgCourse;
  Map<String,dynamic>? university;
  List<dynamic>? internships;
  List<dynamic>? scholarships;
  
  Alumni.fromJson(Map data){
    this.id=data["_id"];
    this.name=data["name"];
    this.username=data["username"];
    this.password=data["password"];
    this.email=data["email"];
    this.company=data["company"];
    this.ugDept=data["ugDept"];
    this.ugYear=data["ugYear"];
    this.pgYear=data["pgYear"];
    this.city=data["city"];
    this.linkedIn=data["linkedIn"];
    this.internships=data["internships"];
    this.scholarships=data["interships"];
    this.pgCourse=data["pgCourse"];
    this.university=data["university"];
  }

  Map<String,dynamic> toMap(){
    return {
      "_id":this.id,
      "username":this.username,
      "password":this.password,
      "name":this.name,
      "email":this.email,
      "linkedIn":this.linkedIn,
      "city":this.city,
      "company":this.company,
      "ugDept":this.ugDept,
      "ugYear":this.ugYear,
      "pgYear":this.pgYear,
      "pgCourse":this.pgCourse,
      "university":this.university,
      "internships":this.internships,
      "scholarships":this.scholarships
    };
  }

}