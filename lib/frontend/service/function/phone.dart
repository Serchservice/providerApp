import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provide/lib.dart';

Future pickImage({required context, required ImageSource source}) async {
  PermissionStatus permitStatus;
  try{
    if(Platform.isAndroid){
      permitStatus = await Permission.storage.request();
    } else {
      permitStatus = await Permission.photos.request();
    }

    if(permitStatus.isGranted){
      final image = await ImagePicker().pickImage(source: source);
      if(image == null){
        return;
      } else {
        Navigator.of(context).push(ViewPickedImage.route(image: image.path, file: image));
      }
    } else if(Platform.isIOS || permitStatus.isPermanentlyDenied || permitStatus.isDenied){
      showGetSnackbar(
        message: "Storage permission is not granted. Allow access through permission settings.",
        type: Popup.error,
        duration: const Duration(seconds: 5)
      );
    }
  } on PlatformException catch (e) {
    showGetSnackbar(message: e.message ?? "Error occurred", type: Popup.error);
  }
}

Future pickFile({
  required FileType type, required context, bool allowMultiple = false, List<String>? allowedExtensions
}) async {
  try{
    PermissionStatus permitStatus;
    if(Platform.isAndroid){
      permitStatus = await Permission.storage.request();
    } else {
      permitStatus = await Permission.photos.request();
    }

    if(permitStatus.isGranted){
      final file = await FilePicker.platform.pickFiles(
        type: type,
        allowMultiple: allowMultiple,
        allowedExtensions: allowedExtensions,
        withData: true,
        withReadStream: true
      );
      if(file == null){
        return;
      }else if(allowMultiple == false){
        final image = file.files.first;
        if(image.path == null) {
          return;
        } else {
          Navigator.of(context).push(ViewPickedImage.route(image: image.path!, imageFile: image));
        }
      } else if(allowMultiple == true){
        Navigator.of(context).push(ViewPickedFiles.route(
          files: file.files,
          onDependFile: openFile
        ));
      }
    }
  } on PlatformException catch (e){
    showGetSnackbar(message: e.message ?? "Error occurred", type: Popup.error);
  }
}

void openFile(PlatformFile file){
  OpenFilex.open(file.path);
}

Future<String?> cropImage({
  required String image, required context, CropStyle cropStyle = CropStyle.circle,
  String titled = "Edit Profile Picture",
}) async {
  CroppedFile? croppedImage = await ImageCropper().cropImage(
    sourcePath: image,
    cropStyle: cropStyle,
    compressFormat: ImageCompressFormat.jpg,
    compressQuality: 100,
    maxHeight: MediaQuery.of(context).size.height.toInt(),
    maxWidth: MediaQuery.of(context).size.width.toInt(),
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: titled,
        toolbarColor: Theme.of(context).bottomAppBarColor,
        toolbarWidgetColor: Theme.of(context).primaryColorLight,
        statusBarColor: Theme.of(context).primaryColorDark,
        dimmedLayerColor: Theme.of(context).scaffoldBackgroundColor,
        activeControlsWidgetColor: Theme.of(context).primaryColorDark,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: true
      ),
      IOSUiSettings(
        title: titled,
      ),
      WebUiSettings(
        context: context,
        presentStyle: CropperPresentStyle.dialog,
        boundary: const CroppieBoundary(
          width: 520,
          height: 520,
        ),
        viewPort:
            const CroppieViewPort(width: 480, height: 480, type: 'circle'),
        enableExif: true,
        enableZoom: true,
        showZoomer: true,
      ),
    ],
  );
  if (croppedImage == null){
    return null;
  } else {
    return croppedImage.path;
  }
}

Future<ImageSource?> showImageSource(context) async {
  if(Platform.isIOS){
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const SText(text: "Camera"),
            onPressed: () => Navigator.of(context).pop(ImageSource.camera)
          ),
          CupertinoActionSheetAction(
            child: const SText(text: "Gallery"),
            onPressed: () => Navigator.of(context).pop(ImageSource.gallery)
          ),
        ]
      )
    );
  } else {
    return showModalBottomSheet(
      context: context,
      enableDrag: false,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const SText(text: "Camera"),
            onTap: () => Navigator.of(context).pop(ImageSource.camera)
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const SText(text: "Gallery"),
            onTap: () => Navigator.of(context).pop(ImageSource.gallery)
          ),
        ]
      )
    );
  }
}