import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const SearchBarWidget({super.key, required this.controller, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity, 
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: "Search Country",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12),
            alignLabelWithHint: true, 
          ),
          onChanged: onSearch,
        ),
      ),
    );
  }
}
