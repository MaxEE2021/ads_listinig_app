import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:classified_app/models/controllers.dart';
import 'package:classified_app/widgets/custom_btn_widget.dart';
import 'package:classified_app/widgets/gallery_item_widget.dart';
import 'package:classified_app/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CreateAddScreen extends StatefulWidget {
  CreateAddScreen({Key? key}) : super(key: key);

  @override
  _CreateAddScreenState createState() => _CreateAddScreenState();
}

class _CreateAddScreenState extends State<CreateAddScreen> {
 APIData _user = Get.put(APIData());
  var titleController = TextEditingController();
  var priceController = TextEditingController();
  var numberController = TextEditingController();
  var desController = TextEditingController();

  var isCaptured = false;
  var path;
  List path2=[];
  // var imagesUploaded = [];
  var localImages=[];

  Future capture()async{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery).then((file){
      print(file!.path);
      setState(() {
        isCaptured = true;
        path = file.path;
        // path = File(file.path);
      });
    });
  }


  caputureMultipleImg() async {
      await ImagePicker().pickMultiImage().then((file) {
        for(int x=0;x<file!.length; x++){
          // print(file[x].path);
          path2.add(file[x].path);
        }
        // print(path2);
        // print(path2.length);
        setState(() {
          isCaptured=true;
        });
        // _user.updateImages(path2);
      });
    }

    Future myfunction () async{
    // var imagesUploaded = [];
    var apiUrlAdPictures=Uri.parse("https://adlisting.herokuapp.com/upload/photos"); 
    var images = await ImagePicker().pickMultiImage();
      var request = http.MultipartRequest('POST', apiUrlAdPictures);
      images!.forEach((image) async {
        print(image.path.toString());
        localImages.add(image.path.toString());
        request.files.add(
          await http.MultipartFile.fromPath(
            'photos',
            image.path,
          ),
        );
      });
      var response = await http.Response.fromStream(await request.send());
      var data = json.decode(response.body);
      print(data["data"]);
      // imagesUploaded=data["data"]["path"];
      // print("LocalImagesPath:  ${localImages}");
      setState(() {
          _user.imagesUploaded=data["data"]["path"];
          isCaptured=true;
        });
    }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Add"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:10 ,bottom: 20),
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
                    ),
                  ),
                  style: TextButton.styleFrom(
                     primary: Colors.black
                  ),
                  onPressed: (){
                    print("upload a picture");
                    // capture();
                    // caputureMultipleImg();
                    myfunction();
                    // caputureMultipleImg();

                  },

                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  // height: 100,
                  // color: Colors.blue,
                  child: isCaptured ?
                  // Row(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal:15.0),
                  //       child: GalerryItemWidget(
                  //         fileimg: path,
                  //       ),
                  //     ),
                  //   ],
                  // )

                  Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _user.imagesUploaded.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0),
                          child: GalerryItemWidget(
                            fileimg: _user.imagesUploaded[index],
                          ),
                        );
                      },
                    ),
                  )
                  :
                  Container(
                    height: 5,
                  )
                ),
              ),

              // Container(
              //   child: isCaptured ?
              //   Image.file(
              //     path,
              //     height: 100,
              //     width: 100,
              //   )
              //   :
              //   Container()
              //   ,
              // ),




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
                customTextFieldController: desController,
                customHintText: "Description",
                textType: TextInputType.text,
                customMaxLines: 3,
              ),

              CustomButtonWidget(
                buttonText: "Submit Ad",
                buttonFunction: (){
                  createNewAd();
                },
              )
              
            ],
          ),
        ),
      ),
    );
  }


  Future createNewAd()async{
    // _user.updateImages(path2);
    var url = "https://adlisting.herokuapp.com/ads"; 
    Map<String,String> createAdHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Barrer ${_user.userToken}'
    };
    Map createAdBody = {
      "title": "${titleController.text}",
      "description": "${desController.text}",
      "price": priceController.text,  ///has to be int
      "mobile": "${numberController.text}",
      "images":_user.imagesUploaded,
    };

    if(titleController.text.isNotEmpty  && numberController.text.isNotEmpty && priceController.text.isNotEmpty){
      try{
        await http.post(
          Uri.parse(url),
          headers: createAdHeaders,
          body: jsonEncode(createAdBody),
        ).then((response) {
          print("succesfully conecnted to uploadNewAd server");
          print("new ad created");
          print(response.statusCode);
          var resp = json.decode(response.body);
          print(resp);
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