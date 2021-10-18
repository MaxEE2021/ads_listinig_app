
import 'dart:ui';

import 'package:classified_app/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class CardItemWidget extends StatefulWidget {
  // CardItemWidget({Key? key}) : super(key: key);
  final String productTitle;
  final String price;
  final String img;
  final String description;
  final VoidCallback? onTap;
  final List? images;
  final String mobile;

  const CardItemWidget ({
    this.productTitle="Product Title",
    this.price="99999",
    this.img="",
    this.description="product desc",
    this.onTap,
    this.images,
    this.mobile="",
  });

  @override
  _CardItemWidgetState createState() => _CardItemWidgetState();
}

class _CardItemWidgetState extends State<CardItemWidget> {
  // var img = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2F1.bp.blogspot.com%2F-xcWvwdrImsw%2FXvBUGEeyuHI%2FAAAAAAAChoE%2FDNsscKqWxmMKNDaEZrKVd9uE6baHrg7ggCLcBGAsYHQ%2Fs1600%2Fscarlett-johansson-under-the-skin-premiere-in-venice-20.jpg&f=1&nofb=1";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.img) 
                ),
              )
            ),
      
            Column(
              children: [
                Expanded(
                  child: Container(
                  ),
                ),
                Container(
                  width: double.infinity,
                  color : Color(0x8f151515),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productTitle,
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        Text(
                          "\$ ${widget.price}",
                          style: TextStyle(
                            color: Colors.orange
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        onTap: widget.onTap == null ? 
          (){
            print("you clicked the product");
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProducDetailsScreen(
              title : widget.productTitle,
              price: widget.price,
              img: widget.img,
              desc: widget.description,
              images: widget.images,
              mobile: widget.mobile,
            )));
          }
          :
          widget.onTap,
      ),
    );
  }
}