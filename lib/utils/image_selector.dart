import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageSelector {
  static final ImageSelector _instance = ImageSelector._constructor();
  factory ImageSelector() {
    return _instance;
  }

  ImageSelector._constructor();
  Future<File> selectImage() async {
    return await ImagePicker.pickImage(source: ImageSource.gallery);
  }
}

final imageSelector = ImageSelector();
