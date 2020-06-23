import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key key,
    this.onChanged,
    this.hintText = 'Search',
  }) : super(key: key);
  final ValueChanged onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 0, // 5 top and bottom
        ),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          onChanged: onChanged,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black.withOpacity(.5)),
          ),
        ),
      ),
    );
  }
}
