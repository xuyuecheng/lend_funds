import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class ImageCompressUtil {
  /// 图片压缩 File -> File
  Future<XFile> imageCompressAndGetFile(File file) async {
    // if (file.lengthSync() < 200 * 1024) {
    //   return file;
    // }
    var quality = 100;
    if (file.lengthSync() > 4 * 1024 * 1024) {
      quality = 30;
    } else if (file.lengthSync() > 2 * 1024 * 1024) {
      quality = 40;
    } else if (file.lengthSync() > 1 * 1024 * 1024) {
      quality = 50;
    } else if (file.lengthSync() > 0.5 * 1024 * 1024) {
      quality = 60;
    } else if (file.lengthSync() > 0.25 * 1024 * 1024) {
      quality = 60;
    }
    var dir = await path_provider.getTemporaryDirectory();
    var targetPath = "${dir.absolute.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 30,
      rotate: 270,
    );
    return XFile(targetPath);
  }

  /// 图片压缩 File -> Uint8List
  Future<Uint8List?> imageCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 94,
      rotate: 90,
    );
    return result;
  }

  /// 图片压缩 Asset -> Uint8List
  Future<Uint8List?> imageCompressAsset(String assetName) async {
    var list = await FlutterImageCompress.compressAssetImage(
      assetName,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 180,
    );

    return list;
  }

  /// 图片压缩 Uint8List -> Uint8List
  Future<Uint8List> testComporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 135,
    );
    return result;
  }
}

