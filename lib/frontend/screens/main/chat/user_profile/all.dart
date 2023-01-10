import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class UserProfileAll extends StatefulWidget {
  const UserProfileAll({super.key});

  @override
  State<UserProfileAll> createState() => _UserProfileAllState();
}

class _UserProfileAllState extends State<UserProfileAll> {
  int count = 0;
  List<PlatformFile>? files;
  @override
  Widget build(BuildContext context) {
    List<CallModel> allFilesList = [
    ];

    if(files == null && allFilesList.isEmpty){
      return const SliverPadding(
        padding: EdgeInsets.all(100.0),
        sliver: SliverToBoxAdapter(
          child: Center(
            child: SText(
              text: "You have no files",
              color: SColors.hint,
              size: 18
            )
          ),
        ),
      );
    } else {
      return SliverGrid(
        delegate: SliverChildBuilderDelegate(
            ((context, index) {
              final file = files![index];
              return fileWidget(
                file: file,
                context: context,
                onLongPress: () {
                  setState(() {
                    count = index;
                  });
                },
              );
            })
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8
        ),
      );
    }
  }
}