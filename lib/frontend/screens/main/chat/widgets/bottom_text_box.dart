
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class PickEmoji extends StatelessWidget {
  final TextEditingController text;
  final double? height;

  const PickEmoji({super.key, required this.text, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: EmojiPicker(
        textEditingController: text,
        // onEmojiSelected: (category, emoji) {
        //   setState(() {
        //     text.text = text.text + emoji.emoji;
        //   });
        // },
        config: Config(
          columns: 7,
          // Issue: https://github.com/flutter/flutter/issues/28894
          emojiSizeMax: 32 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.30 : 1.0),
          verticalSpacing: 0,
          horizontalSpacing: 0,
          gridPadding: EdgeInsets.zero,
          initCategory: Category.RECENT,
          bgColor: const Color(0xFFF2F2F2),
          indicatorColor: Colors.blue,
          iconColor: Colors.grey,
          iconColorSelected: Colors.blue,
          backspaceColor: Colors.blue,
          skinToneDialogBgColor: Colors.white,
          skinToneIndicatorColor: Colors.grey,
          enableSkinTones: true,
          showRecentsTab: true,
          recentsLimit: 28,
          replaceEmojiOnLimitExceed: false,
          noRecents: const Text(
            'No Recents',
            style: TextStyle(fontSize: 20, color: Colors.black26),
            textAlign: TextAlign.center,
          ),
          loadingIndicator: const SizedBox.shrink(),
          tabIndicatorAnimDuration: kTabScrollDuration,
          categoryIcons: const CategoryIcons(),
          buttonMode: ButtonMode.MATERIAL,
          checkPlatformCompatibility: true,
        ),
      ),
    );
  }
}

showMore(context) => showModalBottomSheet(
  context: context,
  barrierColor: Colors.transparent,
  backgroundColor: Colors.transparent,
  elevation: 0,
  builder: (context) => StatefulBuilder(
    builder: (context, setState) => Padding(
      padding: const EdgeInsets.only(bottom: 60.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: Theme.of(context).backgroundColor,
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              spacing: 10,
              runSpacing: 5,
              alignment: WrapAlignment.spaceBetween,
              children: [
                SIconTextButton(
                  icon: Icons.insert_drive_file_rounded,
                  onClick: () => pickFile(
                    context: context, type: FileType.any,
                    allowMultiple: true,
                  ),
                  color: SColors.blue,
                  text: "Document"
                ),
                SIconTextButton(
                  icon: Icons.camera_alt_rounded,
                  onClick: () => Get.to(() => const CameraScreen()),
                  color: SColors.lightPurple,
                  text: "Camera"
                ),
                SIconTextButton(
                  icon: Icons.insert_photo_rounded,
                  onClick: () => pickFile(
                    context: context, type: FileType.image,
                    allowMultiple: true,
                  ),
                  color: SColors.virgo,
                  text: "Gallery"
                ),
                SIconTextButton(
                  icon: Icons.headphones_rounded,
                  onClick: () => pickFile(
                    context: context, type: FileType.audio,
                    allowMultiple: true,
                  ),
                  color: SColors.aries,
                  text: "Audio"
                ),
              ]
            ),
          ),
        )
      ),
    ),
  )
);

