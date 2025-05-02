import 'package:flutter/material.dart';

class BookImageWidget extends StatelessWidget {
  final String imageUrl;

  const BookImageWidget({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(imageUrl, width: 100, height: 150);
  }
}
