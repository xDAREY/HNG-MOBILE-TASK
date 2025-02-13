import 'package:flutter/material.dart';

class PaginationLoader extends StatelessWidget {
  final bool isLoading;

  const PaginationLoader({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
