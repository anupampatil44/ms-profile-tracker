// ignore_for_file: unused_import, prefer_typing_uninitialized_variables, non_constant_identifier_names, null_argument_to_non_null_type, avoid_print

import 'package:fluttertoast/fluttertoast.dart';
import 'package:mongo_dart/mongo_dart.dart';

const String uri="mongodb+srv://admin:admin123@cluster0.m2h8j.mongodb.net/MS_Profiles_Tracker?retryWrites=true&w=majority";

class MongoDB{
  static var db,alumni_collection,student_collection;

  static connect() async{
    db=await Db.create(uri);
    await db.open();
    alumni_collection=db.collection("alumnis");
  }
  
  static Future<List<Map<String,dynamic>>>getDocuments() async{
    try{
        final alumnis=await alumni_collection.find().toList();
        return alumnis;
    }
    catch(e){
      print(e);
      return Future.value();
    }
  }  
  
//db.products.find( { sku: { $regex: /789$/ } } )

  static Future<List<Map<String,dynamic>>>searchDocs(Map<String,dynamic> data) async{
    try{
        final alumnis=await alumni_collection.find({r'$or':[{"fullname":data["fullname"]},{"pgCourse.name":data["pgCourse"]},{"university.name":data["universityName"]}]}).toList();
        return alumnis;
    }
    catch(e){
      print(e);
      return Future.value();
    }
  }  
  
  static Future<Map<String,dynamic>>findOne(Map<String,dynamic> data) async{
    try{
        final alumnis=await alumni_collection.findOne(data);
        return alumnis;
    }
    catch(e){
      print(e);
      return {};
    }
  }

  static Future<void> insertDoc(Map<String,dynamic> data) async{
    try{
      await alumni_collection.insert(data);
      Fluttertoast.showToast(msg: "Inserted");
    }
    catch(e){
      print(e);
      Fluttertoast.showToast(msg: "Error Occrred");
    }
  }

  static updateDoc(Map<String,dynamic> data) async{
    try{
      var res = await alumni_collection.findOne({"username":data["username"],"password":data["password"]});
      res=data;
      await alumni_collection.save(data);
      Fluttertoast.showToast(msg: "Updated");
    }
    catch(e){
      Fluttertoast.showToast(msg: "Error Occurred");
    }
  }
}