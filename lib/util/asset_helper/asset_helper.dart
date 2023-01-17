import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sitesurface_flutter_starter_project/constants/assets/asset_constants.dart';
import 'package:sitesurface_flutter_starter_project/util/styles/colors/pallet.dart';

/// Send either Network image , file path , lottie or asset image
class AssetHelper extends StatelessWidget {
  /// Send either Network image , file path , lottie or asset image in image property
  const AssetHelper(
      {super.key,
      required this.image,
      this.height,
      this.width,
      this.fit,
      this.showLoader = true});
  final String? image;
  final double? height, width;
  final BoxFit? fit;
  final bool showLoader;

  Widget errorImageWidget() => Image.asset(
        AssetConstants.iconApplogo,
        height: height,
        width: width,
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
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Theme.of(context).colorScheme.white,
                  height: height,
                  width: width,
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
        errorBuilder: (_, __, ___) => errorImageWidget(),
      );
    } else if (image!.endsWith(".svg")) {
      return SvgPicture.asset(image ?? "",
          height: height, width: width, fit: fit ?? BoxFit.cover);
    } else if (image!.endsWith(".json") || image!.endsWith(".lottie")) {
      return Lottie.asset(image!,
          height: height,
          width: width,
          errorBuilder: (context, error, stackTrace) => errorImageWidget(),
          fit: fit ?? BoxFit.cover);
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
