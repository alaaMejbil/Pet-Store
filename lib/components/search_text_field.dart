import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(50)),
      child: TextField(
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.grey.withOpacity(0.5)),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle:
                TextStyle(color: Colors.grey.withOpacity(0.5), fontSize: 17)),
      ),
    );
  }
}
