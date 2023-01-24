import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class FileUploadHelper {
  static Future<String?> compressAndUploadImage({
    required File fileName,
  }) async {
    var compressFile = await FlutterImageCompress.compressWithFile(
      fileName.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 94,
    );
    File? tfile;
    if (compressFile != null) {
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/image.jpg').create();
      file.writeAsBytesSync(compressFile);
      tfile = file;
    }
    return await uploadImage(tfile);
  }

  static String? _getFileExtensionFromUrl(String url) {
    RegExp regExp = RegExp(r'(?:\.([^.]+))?$');
    return regExp.firstMatch(url)?.group(1);
  }

  static Future<String?> uploadImage(File? file) async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (file == null) return null;
    String baseName =
        "${DateTime.now().millisecondsSinceEpoch}.${_getFileExtensionFromUrl(file.path) ?? ""}";
    try {
      TaskSnapshot task = await FirebaseStorage.instance
          .ref(currentUser?.uid)
          .child("images/$baseName")
          .putFile(file);
      var link = await task.ref.getDownloadURL();
      return link;
    } catch (e) {
      return null;
    }
  }
}
