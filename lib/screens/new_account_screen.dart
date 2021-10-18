

import 'dart:convert';
// import 'dart:html';
import 'dart:typed_data';

import 'package:classified_app/widgets/custom_btn_widget.dart';
import 'package:classified_app/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'package:http/http.dart' as http;

class NewAccountScreen extends StatelessWidget {
  // const NewAccountScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var numberController = TextEditingController();

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
              // height: size.height *0.58,
              // color: Colors.indigo,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    CustomTextFieldWidget(
                      customTextFieldController: nameController,
                      customHintText: "Full Name",
                      textType: TextInputType.text,
                    ),
                    CustomTextFieldWidget(
                      customTextFieldController: emailController,
                      customHintText: "Email Address",
                      textType: TextInputType.emailAddress,
                    ),
                    CustomTextFieldWidget(
                      customTextFieldController: numberController,
                      customHintText: "Mobile Number",
                      textType: TextInputType.number,
                    ),
                    CustomTextFieldWidget(
                      customTextFieldController: passwordController,
                      customHintText: "Password",
                      textType: TextInputType.text,
                      isPassword: true,
                    ),

                    CustomButtonWidget(
                      buttonText: "Registe Now",
                      buttonFunction: (){
                        print("Regitration sended");
                        print(nameController.text);
                        print(emailController.text);
                        print(passwordController.text);
                        CreateNewAccount();
                      },
                    ),

                    TextButton(
                      child: Text(
                        "Already have an account?",
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
            )
         
          ],
        ),
        
      ),
    );
  }


    Future<void> CreateNewAccount() async{
      // Map jsonstring ={
      //     "name":"Maximiliano",
      //     "email":"MaxEE@appmaking.co",
      //     "password": "123456",
      //     "mobile":"+529994419210"
      // };
      Map jsonstring2 ={
        "name"   : "${nameController.text}",
        "email"  : "${emailController.text}",
        "password": "${passwordController.text}",
        "mobile" : "${numberController.text}"
      };
      Map jsonstring ={
        "name":"sundar2",
        "email":"sundar2@appmaking.co",
        "password": "123456",
        "mobile":"+919876543210"
      };
      Map<String,String> newAccountHeaders={
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      // 'Authorization':'Barrer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTYxN2JlOWUwNWQ5ZjQxYjk5Zjk1NmYiLCJpYXQiOjE2MzQ0NDAzNDl9.c550V7UtiICZ66flyzmdo7O0Sksvh1Oq4kFbOf6um7o'
    };

    if(passwordController.text.isNotEmpty && emailController.text.isNotEmpty){
      print(jsonstring);
      print("Jsonstring2 empieza");
      print(jsonstring2);
      var response = await http.post(Uri.parse("https://adlisting.herokuapp.com/auth/register"),
      headers: newAccountHeaders,
      // headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: (jsonEncode(jsonstring2)),
      );
      if(response.statusCode==200){
        print("data sended to the server succesfully");
        // print(response.body);
        var resp = json.decode(response.body);
        // print(resp);
        if(resp["status"]=="true"){
          print(resp["data"]["userId"]);
          var userId = resp["data"]["userId"];
        }
        else{
          print(resp["message"]);
        }
      }
      else{
        print("an erro has ocurred");
        print(response.statusCode);
        print(response.headers);
        print(response.body);
      }
    }
    else{
      print("the fields must be filled");
    }
    
  }
}

