import 'package:classified_app/widgets/my_add_card_widget.dart';
import 'package:flutter/material.dart';

class MyAddsScreen extends StatelessWidget {
  const MyAddsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Ads"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: MyAddCardWidget(),
              ),
            );
          },
        ),
      ),
    );
  }
}