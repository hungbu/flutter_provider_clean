import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class Avatar extends StatelessWidget {
  final String url;
  const Avatar({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8),
      width: 30,
      height: 30,
      decoration: BoxDecoration(shape: BoxShape.circle,
          image: DecorationImage(image: CachedNetworkImageProvider(url))
      ),
    );
  }
}

