
import 'dart:convert';

import 'package:classified_app/models/controllers.dart';

import 'package:classified_app/screens/create_add_screen.dart';

import 'package:classified_app/screens/settings_screen.dart';
import 'package:classified_app/widgets/card_item_widget.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';


// import 'edit_add_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  APIData _apiData = Get.put(APIData());
  // @override
  // void initState() {
  //   super.initState();
    
  // }
  firstTimeGettingReq(){
    adsRequest();
    userRequest();
    _apiData.userAdsRequest();
    // print("Obtaining request for first time");
  }
  var img = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2F1.bp.blogspot.com%2F-xcWvwdrImsw%2FXvBUGEeyuHI%2FAAAAAAAChoE%2FDNsscKqWxmMKNDaEZrKVd9uE6baHrg7ggCLcBGAsYHQ%2Fs1600%2Fscarlett-johansson-under-the-skin-premiere-in-venice-20.jpg&f=1&nofb=1";
  // List data = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final _apiTokenProvider = Provider.of<ApiInfo>(context); 
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo_outlined),
        backgroundColor: Colors.deepOrange,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
          CreateAddScreen()));
        }
      ),
      appBar: AppBar(
        title: Text("Adds Listing"),
        backgroundColor: Colors.black,
        actions: [
          TextButton(
            child: CircleAvatar(
              // radius: 30,
              // backgroundImage: NetworkImage(img),
              backgroundImage: _apiData.usereData["imgURL"] == null ? NetworkImage(img)
              : 
              NetworkImage(_apiData.usereData["imgURL"],),
            ),
            style: TextButton.styleFrom(
              shape: CircleBorder()
            ),
            onPressed: (){
              _apiData.userAdsRequest();
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
          ),
        ],
      ),
      body: Center(
        // child: data.length == 0 ?
        child: _apiData.data.length == 0 ?
        firstTimeGettingReq()
        :
        RefreshIndicator(
          backgroundColor: Colors.deepOrange,
          color: Colors.white,
          displacement: 8,
          strokeWidth: 3,
          onRefresh: adsRequest,
          // onRefresh: (){return firstTimeGettingReq();},
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: size.height * 0.0014,
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _apiData.data.length,
              itemBuilder: (BuildContext context, int index) {
                return CardItemWidget(
                  img: _apiData.data[index]["images"][0],
                  productTitle: _apiData.data[index]["title"],
                  price: _apiData.data[index]["price"].toString(),
                  description: _apiData.data[index]["description"],
                  images: _apiData.data[index]["images"],
                  mobile: _apiData.data[index]["mobile"],
                  // price: "9999",
                );
              },
            ),
          ),
        ),
      )
    );
  }

  Future adsRequest() async{
    var url = "https://adlisting.herokuapp.com/ads";

    await http.get(Uri.parse(url)).then((resp){
      print(resp.statusCode);
      var _resp = jsonDecode(resp.body);
      setState(() {
        // data = _resp["data"];
        _apiData.data = _resp["data"];
      });
    }).catchError((e){
      print(e);
    });
  }
  

  Future<void> userRequest() async{
    print("Aqui token var ${_apiData.userToken}");
    var url="https://adlisting.herokuapp.com/user/profile";
    Map<String,String> userheaders={
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Barrer ${_apiData.userToken}'
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
          setState(() {
            _apiData.usereData = resp["data"];
          });
         
        }).catchError((e){
          print("an error has ocurred in homepge");
          print(e);
        });
      }
      catch(e){
        print(e);
      }
  }



} 
