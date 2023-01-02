import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class ViewPickedImage extends StatefulWidget {
  static Route route({
    required String image
  }) => MaterialPageRoute(builder: (context) => ViewPickedImage(image: image,));

  final String image;
  const ViewPickedImage({super.key, required this.image});

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
        actions: [
          IconButton(
            onPressed: () async {
              final image = await cropImage(image: imagePicture, context: context);
              if(image == null) return;
              setState(() => imagePicture = image);
              Get.offUntil(GetPageRoute(page:() => EditProfileScreen(image: imagePicture)), (route) => false);
            },
            icon: Icon(
              Icons.crop_rotate_outlined,
              size: 24,
              color: Theme.of(context).primaryColor
            )
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: Image.file(
                  File(imagePicture),
                  fit: BoxFit.cover
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SButton(
                text: "Save",
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8.0),
                textWeight: FontWeight.bold,
                textSize: 18,
                onClick: () => Get.offUntil(GetPageRoute(page:() => EditProfileScreen(image: imagePicture)), (route) => false),
              ),
            ),
          ],
        )
      ),
    );
  }
}