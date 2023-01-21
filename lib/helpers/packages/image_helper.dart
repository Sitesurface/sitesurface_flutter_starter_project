import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sitesurface_flutter_starter_project/styles/colors/pallet.dart';

class ImageHelper {
  final ImagePicker _picker = ImagePicker();
  static ImageSource? _source;

  Future<List<File>> pickMultiImage() async {
    List<File> imageFileList = [];
    try {
      final List<XFile> images =
          (await _picker.pickMultiImage(maxHeight: 500, maxWidth: 500));
      for (var item in images) {
        imageFileList.add(File(item.path));
      }
    } on PlatformException catch (e) {
      if (e.code == "photo_access_denied") {
        // showToast("Photo access denied, please enable it in settings");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return imageFileList;
  }

  Future<File?> pickImage(BuildContext context,
      {ImageSource? imgSource}) async {
    if (imgSource == null && _source == null) {
      await _showImageSourceDialog(context);
    }
    if (imgSource == null && _source == null) {
      return null;
    }

    try {
      final XFile? image = await _picker.pickImage(
          source: imgSource ?? _source!, maxHeight: 500, maxWidth: 500);
      _source = null;
      if (image != null) {
        return File(image.path);
      }
      return null;
    } on PlatformException catch (e) {
      if (e.code == "photo_access_denied") {
        // showToast("Photo access denied, please enable it in settings");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<String> convertImageToBase64(File file) async {
    var base64 = base64Encode(await file.readAsBytes());
    var extension = file.path.split('.').last;
    var base64String = 'data:image/$extension;base64,$base64';
    return base64String;
  }

  Future<void> _showImageSourceDialog(BuildContext context) async {
    //show bottom sheet to select camera or gallery
    await showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) {
          return Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        MdiIcons.camera,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: const Text(
                        "Camera",
                      ),
                      onTap: () async {
                        _source = ImageSource.camera;
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        MdiIcons.image,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: const Text(
                        "Gallery",
                      ),
                      onTap: () async {
                        _source = ImageSource.gallery;
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ));
        });
  }
}
