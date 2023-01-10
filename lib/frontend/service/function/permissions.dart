import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// Map<Permission, PermissionStatus> statuses = await [
//   Permission.location,
//   Permission.storage,
// ].request();
// debugShow(statuses[Permission.location]);


Future<bool> requestPermission(Permission permission) async {
  if(await permission.isGranted){
    return true;
  } else {
    var result = await permission.request();
    if(result == PermissionStatus.granted){
      return true;
    } else {
      return false;
    }
  }
}


//Create Serch path in platforms
newPath() async {
  Directory? directory;
  if(Platform.isAndroid){
    directory = await getExternalStorageDirectory();
    String serchPath = "";

    List<String> folders = directory!.path.split("/");
    for(int x = 1; x < folders.length; x++){
      String folder = folders[x];

      if(folder != "Android"){
        serchPath += "/$folder";
      } else {
        break;
      }
    }

    serchPath = "$serchPath/Serch";
    directory = Directory(serchPath);
  } else {
    directory = await getTemporaryDirectory();
  }

  if(!await directory.exists()){
    await directory.create(recursive: true);
  }

  // if(await directory.exists()){
  //   folderDirectory = "${directory.path}/$new";
  // }
}