import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path_provider/path_provider.dart';
import 'package:qupai/common_views/line.dart';
import 'package:qupai/values/baseColor.dart';
import 'package:qupai/values/textstyles.dart';


class FileSelect {
  BuildContext mContext;

  FileSelect(BuildContext context) {
    this.mContext = context;
  }

  //拍照或相册
  void selectPhoto( dynamic fileResult({File file, var result})) {
    showModalBottomSheet(
        context: mContext,
        builder: (BuildContext context) {
          return new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  File file = await ImagePicker.pickImage(source: ImageSource.camera);
                  compressAndGetFile(file, fileResult);
                },
                child: Container(
                  color: BaseColor.color_ffffff,
                  constraints: BoxConstraints.expand(height: 44),
                  child: new Text(
                    "拍照",
                    style: TextStyles.color_333333_16,
                  ),
                  alignment: Alignment.center,
                ),
              ),
              Line(),
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  File file = await ImagePicker.pickImage(source: ImageSource.gallery);
                  compressAndGetFile(file, fileResult);
                },
                child: Container(
                  color: BaseColor.color_ffffff,
                  constraints: BoxConstraints.expand(height: 44),
                  child: new Text(
                    "相册",
                    style: TextStyles.color_333333_16,
                  ),
                  alignment: Alignment.center,
                ),
              ),
            ],
          );
        });
  }

  void compressWithFile(File file, dynamic fileResult({File file, var result})) async {
    var fileLength = file.lengthSync();
    var result;
    if (file.lengthSync() > 2 * 1024 * 1024) {
      int quality = 100;
      while (fileLength > 2 * 1024 * 1024) {
        quality -= 5;
        result = await FlutterImageCompress.compressWithFile(
          file.absolute.path,
          quality: quality,
        );
        fileLength = result.length;
      }
    } else {
      result = await file.readAsBytes();
    }
    fileResult(file: file, result: result);
  }

  void compressAndGetFile(File file, dynamic fileResult({File file, var result})) async {
    if (file != null) {
      var fileLength = file.lengthSync();
      String fileName = file.path.substring(file.path.lastIndexOf("/") + 1);
      String newFilePath = await getFilePath(file, fileName);
      var result;
      if (fileLength > 2 * 1024 * 1024) {
        int quality = 100;
        while (fileLength > 2 * 1024 * 1024) {
          quality -= 5;
          result = await FlutterImageCompress.compressAndGetFile(
            file.absolute.path,
            newFilePath,
            quality: quality,
          );
          fileLength = result.lengthSync();
        }
      } else {
        result = file;
      }
      fileResult(file: result, result: null);
    }
  }

  Future getFilePath(File file, String fileName) async {
    String path = (await getApplicationDocumentsDirectory()).path;
    return '$path/$fileName';
  }
}
