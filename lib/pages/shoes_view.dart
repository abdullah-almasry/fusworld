import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ShoesView extends StatelessWidget {

  final String imageUrl;
  ShoesView(this.imageUrl);

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
        ),
      ),
    );

  }
}
