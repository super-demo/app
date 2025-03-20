import 'package:flutter/material.dart';

class MiniAppCard extends StatelessWidget {
  const MiniAppCard(
      {super.key,
      required this.index,
      required this.title,
      required this.imageUrl});

  final int index;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            print('Image $index clicked');
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), // Rounded corners
            child: SizedBox(
              width: 64, // Fixed size for each image
              height: 64,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text(title)
      ],
    );
  }
}
