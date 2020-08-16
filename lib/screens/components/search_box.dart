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
      margin: EdgeInsets.only(bottom: 15),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 0, // 5 top and bottom
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1.5, color: Colors.black45),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
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
