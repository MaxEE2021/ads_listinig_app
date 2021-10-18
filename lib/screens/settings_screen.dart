


import 'package:classified_app/models/controllers.dart';
import 'package:classified_app/screens/edit_account_screen.dart';
import 'package:classified_app/screens/my_adds_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  APIData _user = Get.put(APIData());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.black,
      ),
      body: Padding(padding: EdgeInsetsDirectional.all(20),
      child: Container(
        // height: 230,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right:34.0),
                    child: CircleAvatar(
                      radius: 26,
                      // backgroundImage: NetworkImage("img"),
                      backgroundImage: NetworkImage(_user.usereData["imgURL"]),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // "username",
                          _user.usereData["name"],
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                        Text(
                          // "99999999",
                          _user.usereData["mobile"],
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 16
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "Edit",
                    style:TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 18
                    ),
                  )    
                ],
              ),
              onTap: (){
                setState(() {
                  
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                EditAccountScreen()));
        },
            ),



            InkWell(
              child: Container(
                height: 65,
                child: Row(
                  children: [
                    Icon(Icons.post_add_outlined,
                      color: Colors.black45,
                      size: 34,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:50.0),
                      child: Text(
                        "My Add",
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                MyAddsScreen()));
        },
            ),
            InkWell(
              child: Container(
                height: 65,
                child: Row(
                  children: [
                    Icon(Icons.person_outline,
                      color: Colors.black45,
                      size: 34,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:50.0),
                      child: Text(
                        "About us",
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: (){},
            ),
            InkWell(
              child: Container(
                height: 65,
                child: Row(
                  children: [
                    Icon(Icons.contacts_outlined,
                      color: Colors.black45,
                      size: 34,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:50.0),
                      child: Text(
                        "Contact us",
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: (){},
            ),
          ],
        ),
      ),
      ),
    );
  }

}