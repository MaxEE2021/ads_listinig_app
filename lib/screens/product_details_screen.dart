
import 'package:classified_app/screens/photo_view_gallery.dart';
import 'package:classified_app/widgets/custom_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher.dart';

class ProducDetailsScreen extends StatelessWidget {
  // const ProducDetailsScreen({Key? key}) : super(key: key);

  final String title;
  final String price;
  final String img;
  final String desc;
  final List? images;
  final String mobile;

  const ProducDetailsScreen ({
    this.title="Product title",
    this.price="9999",
    this.img="https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fplanetagracza.pl%2Fwp-content%2Fuploads%2F2016%2F07%2FXbox-One-S.jpg&f=1&nofb=1",
    this.desc="Product description",
    this.images,
    this.mobile="",
  });

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:10.0),
                child: Text(
                  "\$ $price",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange
                  ),
                ),
              ),

              InkWell(
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    // color: Colors.blue,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(img)
                    )
                  ),
                ),
                onTap: (){
                  print(images);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GalleryPage(
                    imageList: images,
                  )));                 
                },
              ),

              Padding(
                padding: const EdgeInsets.only(top:8.0 , bottom: 8.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person_outlined),
                        Text(
                          "all"
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: Row(
                        children: [
                          Icon(Icons.timer_outlined),
                          Text(
                            "4 days ago"
                          )
                        ],
                      ),
                    )
                    
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical:15.0),
                child: Text(
                  desc,
                  
                ),
              ),

              CustomButtonWidget(
                buttonText: "Contact Seller",
                buttonFunction: (){
                  print(mobile);
                  _makePhoneCall("tel:$mobile");
                },
              )
              
            ],
          ),
        ),
      ),
    );
  }
}