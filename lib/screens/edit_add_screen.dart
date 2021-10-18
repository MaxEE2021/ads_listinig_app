import 'dart:convert';

import 'package:classified_app/models/controllers.dart';
import 'package:classified_app/widgets/custom_btn_widget.dart';
import 'package:classified_app/widgets/gallery_item_widget.dart';
import 'package:classified_app/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditAddScreen extends StatefulWidget {
  // EditAddScreen({Key? key}) : super(key: key);
  final List? images;
  final String addID;

  const EditAddScreen ({
    this.images,
    this.addID="",
  });

  @override
  _EditAddScreenState createState() => _EditAddScreenState();
}

class _EditAddScreenState extends State<EditAddScreen> {
  APIData _user = Get.put(APIData());
  var titleController = TextEditingController();
  var priceController = TextEditingController();
  var numberController = TextEditingController();
  var descController = TextEditingController();

  var img = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2F1.bp.blogspot.com%2F-xcWvwdrImsw%2FXvBUGEeyuHI%2FAAAAAAAChoE%2FDNsscKqWxmMKNDaEZrKVd9uE6baHrg7ggCLcBGAsYHQ%2Fs1600%2Fscarlett-johansson-under-the-skin-premiere-in-venice-20.jpg&f=1&nofb=1";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Add"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:10 ,bottom: 25),
                child: TextButton(
                  child: Container(
                    height: size.height*0.18,
                    width: size.width*0.38,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_a_photo_outlined,
                          size: size.width*0.20,
                        ),
                      
                        Text(
                          "Tap to upload",
                          style: TextStyle(
                            fontSize: size.width * 0.05
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      // color: Colors.cyan,
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  style: TextButton.styleFrom(
                     primary: Colors.black
                  ),
                  onPressed: (){

                  },

                ),
              ),


              // Container(
              //   height: 100,
              //   // color: Colors.blue,
              //   child: Row(
              //     children: [
              //       GalerryItemWidget(
              //         img: img,
              //         // height: size.height*0.15 ,
              //         // width: size.height*0.12 ,
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.symmetric(horizontal:15.0),
              //         child: GalerryItemWidget(
              //           img: img,
              //           // height: size.height*0.15 ,
              //           // width: size.height*0.12 ,
              //         ),
              //       ),
              //       // GalerryItemWidget(
              //       //   img: img,
              //       //   // height: size.height*0.15 ,
              //       //   // width: size.height*0.12 ,
              //       // ),
              //     ],
              //   ),
              // ),

              Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.images!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0),
                          child: GalerryItemWidget(
                            img: widget.images![index],
                          ),
                        );
                      },
                    ),
                  ),




              CustomTextFieldWidget(
                customTextFieldController: titleController,
                customHintText: "Title",
                textType: TextInputType.text,
              ),
              CustomTextFieldWidget(
                customTextFieldController: priceController,
                customHintText: "Price",
                textType: TextInputType.number,
              ),
              CustomTextFieldWidget(
                customTextFieldController: numberController,
                customHintText: "Contact Number",
                textType: TextInputType.number,
              ),
              CustomTextFieldWidget(
                customTextFieldController: descController,
                customHintText: "Description",
                textType: TextInputType.text,
                customMaxLines: 3,
              ),

              CustomButtonWidget(
                buttonFunction: (){
                  editAd();
                },
                buttonText: "Submit Ad",
              )
              
            ],
          ),
        ),
      ),
    );
  }

  Future editAd()async{
    print("token :${_user.userToken} ");
    print("userID :${_user.userID} ");
    var url = "https://adlisting.herokuapp.com/ads/${widget.addID}"; 
    Map<String,String> createAdHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Barrer ${_user.userToken}'
    };
    Map editAdBody = {
      "title": "${titleController.text}",
      "description": "${descController.text}",
      "price": priceController.text,  ///has to be int
      "mobile": "${numberController.text}",
      "images":[
        "https://i.ytimg.com/vi/HBjpKfCZ5b4/maxresdefault.jpg",
        "https://i.pinimg.com/originals/4d/8f/67/4d8f67058aa4b29a9daf55bd815124d7.jpg",
        "https://i.ytimg.com/vi/HBjpKfCZ5b4/maxresdefault.jpg"
      ]
    };
 

    if(titleController.text.isNotEmpty  && numberController.text.isNotEmpty && priceController.text.isNotEmpty){
      try{
        await http.patch(
          Uri.parse(url),
          headers: createAdHeaders,
          body: jsonEncode(editAdBody),
        ).then((response) {
          print("succesfully conecnted to uploadNewAd server");
          print("ad edited succesfully");
          print(response.statusCode);
          var resp = json.decode(response.body);
          print(resp);
        }).catchError((e){
          print(e);
          print("an error has occured in edit_add screen");
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