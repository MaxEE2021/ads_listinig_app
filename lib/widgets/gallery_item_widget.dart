import 'dart:io';

import 'package:flutter/material.dart';

class GalerryItemWidget extends StatelessWidget {
  // const GalerryItemWidget({Key? key}) : super(key: key);
  final String img;
  final double height;
  final double width;
  final String fileimg;

  const GalerryItemWidget ({
    this.img="",
    this.height=100,
    this.width=100,
    this.fileimg="",
  });



  @override
  Widget build(BuildContext context) {
    return Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(10),
                // color: Colors.red,
              ),

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: fileimg=="" ? 
                Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(img)
                    )
                  ),
                )
                :
                Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:NetworkImage(fileimg),
                      // image: FileImage(File(fileimg))
                    )
                  ),
                )
              ),
    );
  }
}

