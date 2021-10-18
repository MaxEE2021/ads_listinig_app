import 'dart:convert';

import 'package:classified_app/models/controllers.dart';
import 'package:classified_app/screens/login_screen.dart';
import 'package:classified_app/widgets/custom_btn_widget.dart';
import 'package:classified_app/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditAccountScreen extends StatefulWidget {
  EditAccountScreen({Key? key}) : super(key: key);

  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  APIData _user = Get.put(APIData());
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
     var img = _user.usereData["imgURL"];
    // APIData _user = Get.put(APIData());
      Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Edit Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(img),
                    radius: size.height*0.08,
                  ),
                ),
      
                CustomTextFieldWidget(
                  customTextFieldController: nameController,
                  textType: TextInputType.text,
                  customHintText: "Full Name",
                ),
                CustomTextFieldWidget(
                  customTextFieldController: emailController,
                  textType: TextInputType.emailAddress,
                  customHintText: "Email",
                ),
                CustomTextFieldWidget(
                  customTextFieldController: numberController,
                  textType: TextInputType.number,
                  customHintText: "Phone Number",
                ),
      
                CustomButtonWidget(
                  buttonText: "Update Profile",
                  buttonFunction: (){
                    updateProfile();
                    // userRequest();
                    _user.userRequest();
                  },
                ),
      
                   TextButton(
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.deepOrange
                          ),
                        ),
                        onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogInScreen()));
                        }, 
                      )
      
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future updateProfile()async{
    var url = "https://adlisting.herokuapp.com/user/"; 
    Map<String,String> updateProfileHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Barrer ${_user.userToken}'
    };
    Map updateProfileBody = {
      "name"   : "${nameController.text}",
      // "email"  : "${emailController.text}",
      "mobile" : "${numberController.text}",
      // "imgURL" : "https://i.ytimg.com/vi/HBjpKfCZ5b4/maxresdefault.jpg"
    };
    if(nameController.text.isNotEmpty  && numberController.text.isNotEmpty){
      try{
        await http.patch(
          Uri.parse(url),
          headers: updateProfileHeaders,
          body: jsonEncode(updateProfileBody),
        ).then((response) {
          print("succesfully conecnted to updateProfile server");
          print("Profile data updated");
          print(response.statusCode);
          var resp = json.decode(response.body);
        }).catchError((e){
          print(e);
          print("an error has occured in edit account screen");
        });
      }
      catch(e){
        print(e);
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Fill the blank spaces")));
    }

  }

}