import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: const TextField(
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          label: Text("Search Movies"),
          border: OutlineInputBorder(
          ),
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(vertical: 12)
        ),
      ),
    );
  }
}
