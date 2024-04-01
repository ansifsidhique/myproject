import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class NetWorkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width, height, borderRadius, iconSize;
  const NetWorkImageWidget(
      {super.key,
      required this.imageUrl,
       this.width=40,
       this.height=40,
       this.borderRadius=18,
       this.iconSize=20});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(imageUrl: imageUrl,width: width,
      height: height,

      ),
    );
  }
}
