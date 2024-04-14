import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class imageUploader extends ChangeNotifier {
  var uuid = Uuid();
  final ImagePicker _picker = ImagePicker();
  String? imageUrl;
  String? imagePath;
  List<String> imageFil = [];

  void pickImage() async {
    XFile? _imageFile = await _picker.pickImage(source: ImageSource.gallery);
    _imageFile = await cropImage(_imageFile!);
    if (_imageFile != null) {
      imageFil.add(_imageFile.path);
      uploader(_imageFile);
      imagePath = _imageFile.path;
    }
  }

  Future<XFile?> cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: imageFile.path,
      maxHeight: 800,
      maxWidth: 600,
      compressQuality: 70,
      cropStyle: CropStyle.rectangle,
      aspectRatioPresets: [CropAspectRatioPreset.ratio5x4],
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: Color.fromARGB(255, 235, 238, 240),
          toolbarTitle: 'bifajob cropper',
          toolbarWidgetColor: Color.fromARGB(255, 97, 211, 69),
          initAspectRatio: CropAspectRatioPreset.ratio5x4,
          lockAspectRatio: true,
        ),
      ],
    );

    if (croppedFile != null) {
      notifyListeners();
      return XFile(croppedFile.path);
    } else {
      return null;
    }
  }

  Future<String?> uploader(XFile upload) async {
    File image = File(upload.path);

  final ref = FirebaseStorage.instance
      .ref()
      .child("${uuid.v1()}.jpg");
  await ref.putFile(image);
  imageUrl = (await ref.getDownloadURL());
  print(imageUrl);
  return imageUrl;
  }
}
