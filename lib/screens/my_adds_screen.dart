import 'package:classified_app/models/controllers.dart';
import 'package:classified_app/widgets/my_add_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAddsScreen extends StatelessWidget {
  // const MyAddsScreen({Key? key}) : super(key: key);
  APIData _userAds = Get.put(APIData());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Ads"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _userAds.userAds.length,
          // itemCount: _userAds.userAds.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: _userAds.userAds.length == 0 ?
                MyAddCardWidget() 
                :
                MyAddCardWidget(
                  // img: _userAds.userAds[index]["images"][0],
                  title: _userAds.userAds[index]["title"],
                  price: _userAds.userAds[index]["price"].toString(),
                  images: _userAds.userAds[index]["images"],
                  addID: _userAds.userAds[index]["_id"],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}