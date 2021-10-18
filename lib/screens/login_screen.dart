import 'dart:convert';
import 'dart:ffi';

import 'package:classified_app/models/controllers.dart';
import 'package:classified_app/screens/home_screen.dart';
import 'package:classified_app/screens/new_account_screen.dart';
import 'package:classified_app/widgets/custom_btn_widget.dart';
import 'package:classified_app/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;



class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  APIData _datatoken = Get.put(APIData());
   var emailController = TextEditingController();
   var passwordController = TextEditingController();
   

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 25,

      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // color: Colors.indigo,
              // height: size.height*0.3,
              child: Stack(
                alignment: Alignment.center,
                children: [
      
                  Container(
                    height: size.height *0.42,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/img/background.png") 
                      )
                    ),
                  ),
        
                  Container(
                    height: size.height*0.08,
                    child: Image.asset(
                      "assets/img/logo.png"
                    ),
                  ),
                  // Container(child: Image.asset("assets/img/logo.png"))
                  
                ],
              ),
            ),

            Container(
              height: size.height *0.58,
              // color: Colors.indigo,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    CustomTextFieldWidget(
                      customTextFieldController: emailController,
                      customHintText: "Email",
                      textType: TextInputType.emailAddress,
                    ),
                    CustomTextFieldWidget(
                      customTextFieldController: passwordController,
                      customHintText: "Password",
                      textType: TextInputType.text,
                      isPassword: true,
                    ),

                    CustomButtonWidget(
                      buttonText: "Login",
                      buttonFunction: (){
                        logInRequest();
                      },
                    ),

                    TextButton(
                      child: Text(
                        "Don't have any account?",
                        style: TextStyle(
                          color: Colors.deepOrange
                        ),
                      ),
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewAccountScreen()));
                      }, 
                    )


                  ],
                ),
              ),
            )
         
          ],
        ),
      ),
    );
  }


  Future<void> logInRequest() async{
  var url = "https://adlisting.herokuapp.com/auth/login";

    // Map jsonString ={
    //   "email"   : "${emailController.text}",
    //   "password": "${passwordController.text}"
    // };
    Map jsonString2 ={
      "email":"MaxEE@appmaking.co",
      "password": "123456"
    };
    Map jsonString3 ={
      "email":"MaxEE3@appmaking.co",
      "password": "123456"
    };
    Map jsonString ={
      "email":"MaxEE2@appmaking.co",
      "password": "123456"
    };
    
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      try{
        await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json; charset=UTF-8',},
          body: jsonEncode(jsonString)
        ).then((response) {
          print("succesfully conecnted to the server");
          print(response.statusCode);
          var resp = json.decode(response.body);
          // print(resp);
          print("status: ${resp["status"]}");
          // print(resp["data"]["token"]);
          _datatoken.userToken = resp["data"]["token"];
          _datatoken.userID = resp["data"]["user"]["_id"];
          // print("token from login: ${_datatoken.userToken}");
       
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }).catchError((e){
          print("an error has ocurred in login page");
          print(e);
        });
      }
      catch(e){
        print(e);
      }
    }
    else{
      print("Please fill all the fields");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please introduce email and password")));
    }
  }

 
}