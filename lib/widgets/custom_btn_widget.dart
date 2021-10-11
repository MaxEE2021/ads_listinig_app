import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  // const CustomButtonWidget({Key? key}) : super(key: key);
  final String buttonText;
  final VoidCallback? buttonFunction;

  const CustomButtonWidget ({
    this.buttonText="Button text",
    this.buttonFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.deepOrange,
                  ),
                  child: Text(buttonText),
                  onPressed: buttonFunction == null ? 
                  (){} : 
                  buttonFunction,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}