import 'package:classified_app/screens/edit_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAddCardWidget extends StatelessWidget {
  // const MyAddCardWidget({Key? key}) : super(key: key);
  final String img;
  final String title;
  final String price;
  final List? images;
  final String addID;
  
  const MyAddCardWidget ({
    this.img="https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2F1.bp.blogspot.com%2F-xcWvwdrImsw%2FXvBUGEeyuHI%2FAAAAAAAChoE%2FDNsscKqWxmMKNDaEZrKVd9uE6baHrg7ggCLcBGAsYHQ%2Fs1600%2Fscarlett-johansson-under-the-skin-premiere-in-venice-20.jpg&f=1&nofb=1",
    this.title="Product Title",
    this.price="\$2000",
    this.images,
    this.addID="",
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black26),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 90,
                width: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(images![0])
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:3.0),
                    child: Row(
                      children: [
                        Icon(Icons.timer_outlined),
                        Text(
                          "10 days ago",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    price,
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onTap: (){
        print("you pressed my add card widget");
        Get.to(EditAddScreen(
          images: images,
          addID: addID,
        ));
      },
    );
  }
}