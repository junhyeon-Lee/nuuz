import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuuz/modules/nuzz_care/result/providers/image/repository/image_repository.dart';

class ImageNotifier extends Notifier<File?> {
  final imageRepository = ImageRepository();

  void updateImage(String imagePath) {
    state = File(imagePath);
  }

  void clearImage() {
    state = null;
  }

  @override
  build() {
    return null;
  }

  Future<String> deleteImage() {
    return imageRepository.deleteImage();
  }

  Future<String> uploadImage() {
    return imageRepository.uploadImage(state!.path);
  }
}

final imageController = NotifierProvider<ImageNotifier, File?>(ImageNotifier.new);
