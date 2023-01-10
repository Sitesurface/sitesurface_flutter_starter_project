import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Repo {
  /// Create map and return only those fields that are not null
  Map<String, dynamic> _removeNull(dynamic object) {
    Map<String, dynamic> map = {};
    map.addAll(object.toJson());
    map.removeWhere((key, value) => value == null);
    return map;
  }

  /// Function to get compressed image and upload it to firebase storage
  Future<String?> compressImage({
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

  /// Function to upload image to firebase storage
  Future<String?> uploadImage(File? file) async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (file == null) return null;
    String baseName = basename(file.path);
    try {
      firebase_storage.TaskSnapshot task = await firebase_storage
          .FirebaseStorage.instance
          .ref(currentUser?.uid)
          .child("images/$baseName")
          .putFile(file);
      var link = await task.ref.getDownloadURL();
      return link;
    } catch (e) {
      return null;
    }
  }

  /// Example of repository function
  // Future<dynamic> getConstant() async {
  //   return await ApiHelper.get("/api/settings");
  // }

}
