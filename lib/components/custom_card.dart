import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_image.dart';

class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomImage(
          "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80",
          width: double.infinity,
          height: 160,
          radius: 20,
          fit: BoxFit.cover,
          isShadow: true,
        ),
        Container(
            width: double.infinity,
            height: 160,
            padding: const EdgeInsets.fromLTRB(10, 5, 0, 10),
            decoration: BoxDecoration(
              //color: Colors.red,
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(0.0),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Ahmed Ali',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.star),
                        color: Colors.yellow,
                        iconSize: 20,
                        splashRadius: 2,
                      ),
                    ),
                  ],
                ),
                Text(
                  '160 \$',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ],
            )),
      ],
    );
  }
}
