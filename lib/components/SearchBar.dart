import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;

  const CustomSearchBar({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: TextField(
        controller: controller, // Use the provided controller
        style: const TextStyle(fontSize: 16),
        decoration: const InputDecoration(
          labelText: "Search Movies", // Changed "label" to "labelText"
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
