import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provide/lib.dart';

class ViewPickedImage extends StatefulWidget {
  static Route route({
    required String image, PlatformFile? imageFile, XFile? file
  }) => MaterialPageRoute(builder: (context) => ViewPickedImage(image: image, imageFile: imageFile, file: file,));

  final String image;
  final PlatformFile? imageFile;
  final XFile? file;
  const ViewPickedImage({super.key, required this.image, this.imageFile, this.file});

  @override
  State<ViewPickedImage> createState() => _ViewPickedImageState();
}

class _ViewPickedImageState extends State<ViewPickedImage> {
  @override
  Widget build(BuildContext context) {
    String imagePicture = widget.image;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 2,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            CupertinoIcons.chevron_back,
            color: Theme.of(context).primaryColor,
            size: 24
          )
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.file(
              File(imagePicture),
              fit: BoxFit.cover
            )
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SButton(
                  text: "Save",
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16.0),
                  textWeight: FontWeight.bold,
                  textSize: 18,
                  onClick: () => Get.offUntil(GetPageRoute(page:() => EditProfileScreen(
                    image: imagePicture, imageFile: widget.imageFile, file: widget.file,
                  )), (route) => false),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}