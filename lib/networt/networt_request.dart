import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get_post_api/model/post.dart';
import 'package:http/http.dart'as http;
class NetworkRequest{
  static const String url="https://jsonplaceholder.typicode.com/posts";
  static const String url2="https://nguyenxuantri.xyz/testselect";

  static List<Post>parsePost(String resposeBody){
        var result=json.decode(resposeBody);
        var list=result["result"]as List<dynamic>;
        List<Post>posts=list.map((e) => Post.fromJson(e)).toList();
        return posts;
  }

  static Future <List<Post>>fetchPost()async{
    final response=await http.get(url2);
    if(response.statusCode==200){
      return compute(parsePost,response.body);
      // var result=json.decode(response.body);
      // var list=result["result"] as List<dynamic>;
      // List<Post>posts=list.map((e) => Post.fromJson(e)).toList();
      // return posts;
    }else if(response.statusCode==404){
      print("loi 404");
    }
  }

  //key
  static Future <void>postData({String IdUser,String PhoneUser ,String NameUser,String AddressUser})async{
    try{
       const String url="https://nguyenxuantri.xyz/user";
      var response=await http.post(Uri.parse(url),body: {
          "key":"1234",
        "IdUser":IdUser,
        "PhoneUser":PhoneUser,
        "NameUser":NameUser,
        "AddressUser":AddressUser
      });
      print(response.body);
    }catch(e){
          print("loi$e");
    }
  }
}