import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'assets_constants.dart';

class CacheImgHelper extends StatelessWidget {
  const CacheImgHelper(
      {super.key,
      required this.imageUrl,
      this.height,
      this.width,
      this.fit,
      this.showLoader = false});
  final String? imageUrl;
  final double? height, width;
  final BoxFit? fit;
  final bool showLoader;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return Image.asset(
        AssetConstants.appLogo,
        height: height ?? 10,
        width: width ?? 10,
        fit: fit ?? BoxFit.cover,
      );
    }
    return CachedNetworkImage(
      imageUrl: imageUrl ?? "",
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
      filterQuality: FilterQuality.none,
      placeholder: (context, url) => showLoader
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : const SizedBox(),
      errorWidget: (context, url, error) {
        return Image.asset(
          AssetConstants.appLogo,
          height: height ?? 10,
          width: width ?? 10,
          fit: fit ?? BoxFit.cover,
        );
      },
    );
  }
}
