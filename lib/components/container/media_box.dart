import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:provide/lib.dart';

Widget fileWidget({
  required PlatformFile file,
  required void Function()? onLongPress,
  required BuildContext context
}){
  final kb = file.size / 7024;
  final mb = kb / 1024;
  final fileSize = mb >= 1 ? "${mb.toStringAsFixed(2)} MB" : "${kb.toStringAsFixed(2)} KB";
  final extension = file.extension ?? "none";
  debugShow(file.identifier);
  final color = getExtensionColor(extension);

  return InkWell(
    // onTap: () => widget.onDependFile(file),
    onTap: () => OpenFilex.open(file.path),
    onLongPress: onLongPress,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SText(
              text: '.$extension',
              size: 20,
              color: Theme.of(context).primaryColor
            )
          )
        ),
        const SizedBox(height: 8),
        SText(
          text: file.name,
          size: 18,
          flow: TextOverflow.ellipsis,
          color: Theme.of(context).primaryColor
        ),
        SText(
          text: fileSize,
          size: 16,
          flow: TextOverflow.ellipsis,
          color: Theme.of(context).primaryColor
        ),
      ]
    )
  );
}

Widget userFileWidget({
  required PlatformFile file,
  required void Function()? onLongPress,
  required BuildContext context
}){
  final kb = file.size / 7024;
  final mb = kb / 1024;
  final fileSize = mb >= 1 ? "${mb.toStringAsFixed(2)} MB" : "${kb.toStringAsFixed(2)} KB";
  final extension = file.extension ?? "none";
  debugShow(file.identifier);
  final color = getExtensionColor(extension);

  return InkWell(
    // onTap: () => widget.onDependFile(file),
    onTap: () => OpenFilex.open(file.path),
    onLongPress: onLongPress,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SText(
              text: '.$extension',
              size: 20,
              color: Theme.of(context).primaryColor
            )
          )
        ),
        const SizedBox(height: 8),
        SText(
          text: file.name,
          size: 18,
          flow: TextOverflow.ellipsis,
          color: Theme.of(context).primaryColor
        ),
        SText(
          text: fileSize,
          size: 16,
          flow: TextOverflow.ellipsis,
          color: Theme.of(context).primaryColor
        ),
      ]
    )
  );
}