
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class APIData extends GetxController{
  List data=[];
  String userToken = "hola token";
  String userID = "UserID";

  List imagesUploaded=[];

  // getToken(String token){
  //   userToken=token;
  // }
 

  Map usereData={};
  List userAds=[];

  Future<void> userRequest() async{
    print("Aqui token var ${userToken}");
    var url="https://adlisting.herokuapp.com/user/profile";
    Map<String,String> userheaders={
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Barrer ${userToken}'
      // 'Authorization':'Barrer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTYxN2JlOWUwNWQ5ZjQxYjk5Zjk1NmYiLCJpYXQiOjE2MzQ0NDAzNDl9.c550V7UtiICZ66flyzmdo7O0Sksvh1Oq4kFbOf6um7o'
    };
      try{
        await http.post(
          Uri.parse(url),
          headers: userheaders,
          // body: jsonEncode(jsonString)
        ).then((response) {
          print("Getting user information");

          print(response.statusCode);
          print(response.body);
          var resp = json.decode(response.body);
          usereData = resp["data"];
         
        }).catchError((e){
          print("an error has ocurred in homepge");
          print(e);
        });
      }
      catch(e){
        print(e);
      }
  }



  Future<void> userAdsRequest() async{
    print("Aqui token var ${userToken}");
    var url="https://adlisting.herokuapp.com/ads/user";
    Map<String,String> userheaders={
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Barrer ${userToken}'
    };
      try{
        await http.post(
          Uri.parse(url),
          headers: userheaders,
          // body: jsonEncode(jsonString)
        ).then((response) {
          print("Getting user Ads information");

          print(response.statusCode);
          print(response.body);
          var resp = json.decode(response.body);
          userAds = resp["data"];
         
        }).catchError((e){
          print("an error has ocurred in the adsuser function");
          print(e);
        });
      }
      catch(e){
        print(e);
      }
  }




  // Future updateProfile()async{
  //   var url = "https://adlisting.herokuapp.com/user/"; 
  //   Map<String,String> createAdHeaders = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Barrer ${_user.userToken}'
  //   };
  //   Map createAdBody = {
  //     "name"   : "${nameController.text}",
  //     // "email"  : "${emailController.text}",
  //     "mobile" : "${numberController.text}",
  //     // "imgURL" : "https://i.ytimg.com/vi/HBjpKfCZ5b4/maxresdefault.jpg"
  //   };
  //   if(nameController.text.isNotEmpty  && numberController.text.isNotEmpty){
  //     try{
  //       await http.patch(
  //         Uri.parse(url),
  //         headers: createAdHeaders,
  //         body: jsonEncode(createAdBody),
  //       ).then((response) {
  //         print("succesfully conecnted to updateProfile server");
  //         print("Profile data updated");
  //         print(response.statusCode);
  //         var resp = json.decode(response.body);
  //       }).catchError((e){
  //         print(e);
  //         print("an error has occured in edit account screen");
  //       });
  //     }
  //     catch(e){
  //       print(e);
  //     }
  //   }
  //   else{
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Fill the blank spaces")));
  //   }

  // }

  // Future<void> uploadImages(photosPath) async{
  //   print("Aqui token var ${userToken}");
  //   var url="https://adlisting.herokuapp.com/upload/photos";
  //   Map<String,String> updateImagesheaders={
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Barrer ${userToken}'
  //   };
  //   Map updateImagesbody ={
  //     "photos":{photosPath},
  //   };
  //   var map = new Map<String, dynamic>();
  //   map['photos'] ={photosPath} ;
  //   map['photos'].add(photosPath);
  //     try{
  //       await http.post(
  //         Uri.parse(url),
  //         // headers: userheaders,
  //         // body: jsonEncode(jsonString)
  //         body: updateImagesbody
  //         // body: map
  //       ).then((response) {
  //         print("Updating photos to the server");

  //         print(response.statusCode);
  //         print(response.body);
  //         var resp = json.decode(response.body);
  //         print(resp["data"]);
  //         var urlPhotos = resp["data"];
         
  //       }).catchError((e){
  //         print("an error has ocurred photos cant be updated to server");
  //         print(e);
  //       });
  //     }
  //     catch(e){
  //       print(e);
  //     }
  // }

  



}
