import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sitesurface_flutter_starter_project/constants/assets/icon_constants.dart';
import 'package:sitesurface_flutter_starter_project/util/styles/colors/pallet.dart';

class ImgHelper extends StatelessWidget {
  const ImgHelper(
      {super.key,
      required this.image,
      this.height,
      this.width,
      this.fit,
      this.showLoader = false});
  final String? image;
  final double? height, width;
  final BoxFit? fit;
  final bool showLoader;

  Widget errorImageWidget() => Image.asset(
        IconConstants.applogo,
        height: height ?? 10,
        width: width ?? 10,
        fit: fit ?? BoxFit.cover,
      );

  @override
  Widget build(BuildContext context) {
    if (image == null || image!.isEmpty) {
      return errorImageWidget();
    }
    if (Uri.parse(image!).isAbsolute) {
      return CachedNetworkImage(
        imageUrl: image ?? "",
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        filterQuality: FilterQuality.none,
        placeholder: (context, url) => showLoader
            ? Shimmer.fromColors(
                baseColor: Theme.of(context).colorScheme.background,
                highlightColor:
                    Theme.of(context).colorScheme.white ?? Colors.white,
                child: const SizedBox(
                  height: 10,
                  width: 10,
                ),
              )
            : const SizedBox(),
        errorWidget: (context, url, error) {
          return errorImageWidget();
        },
      );
    } else if (File(image!).existsSync()) {
      return Image.file(
        File(image!),
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
      );
    } else {
      return Image.asset(
        image!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
      );
    }
  }
}
