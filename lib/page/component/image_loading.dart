import 'package:flutter/material.dart';

class ImageLoading extends StatelessWidget {
  final String url;
  const ImageLoading({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      '${url}',
      filterQuality: FilterQuality.high,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        print("still loading");
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return const Center(child: Text("Error!"));
      },
    );
  }
}
