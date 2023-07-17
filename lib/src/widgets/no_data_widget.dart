import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {

  String text = '';

  NoDataWidget({this.text = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/no-product.png', 
            height: 150,
            width: 150,
          ),
          SizedBox(height: 15),
          Text(
            text,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold
            ),
          )
        ]
      ),
    );
  }
}