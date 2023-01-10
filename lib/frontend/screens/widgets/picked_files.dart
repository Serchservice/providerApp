import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class ViewPickedFiles extends StatefulWidget {
  static Route route({
    required List<PlatformFile> files,
    required ValueChanged<PlatformFile> onDependFile,
  }) => MaterialPageRoute(builder: (context) => ViewPickedFiles(
    files: files, onDependFile: onDependFile
  ));

  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onDependFile;
  const ViewPickedFiles({super.key, required this.files, required this.onDependFile});

  @override
  State<ViewPickedFiles> createState() => _ViewPickedFilesState();
}

class _ViewPickedFilesState extends State<ViewPickedFiles> {
  final text = TextEditingController();
  bool emojiShowing = false;
  bool selected = false;
  int count = 0;
  FocusNode focus = FocusNode();

  @override
  void initState() {
    super.initState();
    focus.addListener(() {
      if(focus.hasFocus){
        setState(() => emojiShowing = false);
      }
    }); //Keyboard listener
  }

  @override
  void dispose() {
    focus.dispose();
    super.dispose();
  }

  void open(){
    setState(() => emojiShowing = !emojiShowing);
    if(emojiShowing == true){
      focus.unfocus();
      focus.canRequestFocus = false;
    } else {
      focus.requestFocus();
    }
  }

  Future<bool> backClose() {
    if(emojiShowing == true){
      setState(() => emojiShowing = false);
    } else {
      Navigator.pop(context);
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            CupertinoIcons.chevron_back,
            color: SColors.hint,
            size: 28
          )
        ),
        actions: [
          if(count > 0)
          Center(
            child: SText(
              text: "Delete(${count + 1})",
              color: SColors.red,
              size: 18,
              weight: FontWeight.bold
            ),
          ),
          if(count > 0)
          IconButton(
            onPressed: (){},
            icon: const Icon(
              CupertinoIcons.delete,
              color: SColors.hint
            )
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                child: Center(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8
                    ),
                    itemCount: widget.files.length,
                    itemBuilder: (context, index) {
                      final file = widget.files[index];
                          
                      return fileWidget(
                        file: file,
                        context: context,
                        onLongPress: () {
                          setState(() {
                            count = index;
                          });
                        },
                      );
                    }
                  )
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: TextFormField(
                              focusNode: focus,
                              style: STexts.normalForm(context),
                              cursorColor: Theme.of(context).primaryColor,
                              controller: text,
                              maxLines: 5,
                              minLines: 1,
                              textAlignVertical: TextAlignVertical.center,
                              maxLengthEnforcement: MaxLengthEnforcement.none,
                              textCapitalization: TextCapitalization.sentences,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              // enabled: enabled,
                              // textInputAction: TextInputAction.newline,
                              keyboardType: TextInputType.multiline,
                              // validator: validate,
                              onChanged: (value) => debugShow(value.toString()),
                              decoration: InputDecoration(
                                hintText: "Add Caption...",
                                hintStyle: STexts.hints(context),
                                isDense: true,
                                filled: true,
                                prefixIcon: InkWell(
                                  onTap: () => open(),
                                  child: Icon(
                                    emojiShowing == false ? FontAwesomeIcons.solidFaceGrin
                                    : FontAwesomeIcons.solidKeyboard
                                    ,
                                    color: SColors.hint
                                  ),
                                ),
                                fillColor: Theme.of(context).scaffoldBackgroundColor,
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    width: 1.8,
                                    color: Theme.of(context).disabledColor,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColorDark,
                                    width: 1.8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).backgroundColor,
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              color: Scolors.info3,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: const [
                                SText(
                                  text: "Send to",
                                  color: SColors.black,
                                  weight: FontWeight.bold,
                                  size: 14
                                ),
                              ],
                            )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () => {},
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: SColors.lightPurple,
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: const Icon(
                                CupertinoIcons.paperplane_fill,
                                color: SColors.white,
                                size: 20
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}

class PickedFilesScreen extends StatefulWidget {
  static Route route({
    required List<PlatformFile> files,
    required ValueChanged<PlatformFile> onDependFile,
  }) => MaterialPageRoute(builder: (context) => PickedFilesScreen(
    files: files, onDependFile: onDependFile
  ));

  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onDependFile;
  const PickedFilesScreen({super.key, required this.files, required this.onDependFile});

  @override
  State<PickedFilesScreen> createState() => _PickedFilesScreenState();
}

class _PickedFilesScreenState extends State<PickedFilesScreen> {
  final text = TextEditingController();
  bool emojiShowing = false;
  FocusNode focus = FocusNode();

  @override
  void initState() {
    super.initState();
    focus.addListener(() {
      if(focus.hasFocus){
        setState(() => emojiShowing = false);
      }
    }); //Keyboard listener
  }

  @override
  void dispose() {
    focus.dispose();
    super.dispose();
  }

  void open(){
    setState(() => emojiShowing = !emojiShowing);
    if(emojiShowing == true){
      focus.unfocus();
      focus.canRequestFocus = false;
    } else {
      focus.requestFocus();
    }
  }

  Future<bool> backClose() {
    if(emojiShowing == true){
      setState(() => emojiShowing = false);
    } else {
      Navigator.pop(context);
    }
    return Future.value(false);
  }

  String? image;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            CupertinoIcons.chevron_back,
            color: SColors.hint,
            size: 28
          )
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(
              Icons.crop_rotate_outlined,
              color: SColors.hint
            )
          )
        ],
      ),
      body: SizedBox(
        width: width,
        height: Get.height,
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: height,
                // child: Image.file(File(image!)),
              )
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).backgroundColor,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    height: 70,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.files.length,
                      itemBuilder: (context, index) {
                        final file = widget.files[index];
                        setState(() => image = file.path);

                        return fileWidget(file);
                      }
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: TextFormField(
                              focusNode: focus,
                              style: STexts.normalForm(context),
                              cursorColor: Theme.of(context).primaryColor,
                              controller: text,
                              maxLines: 5,
                              minLines: 1,
                              textAlignVertical: TextAlignVertical.center,
                              maxLengthEnforcement: MaxLengthEnforcement.none,
                              textCapitalization: TextCapitalization.sentences,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              // enabled: enabled,
                              // textInputAction: TextInputAction.newline,
                              keyboardType: TextInputType.multiline,
                              // validator: validate,
                              onChanged: (value) => debugShow(value.toString()),
                              decoration: InputDecoration(
                                hintText: "Add Caption...",
                                hintStyle: STexts.hints(context),
                                isDense: true,
                                filled: true,
                                prefixIcon: InkWell(
                                  onTap: () => open(),
                                  child: Icon(
                                    emojiShowing == false ? FontAwesomeIcons.solidFaceGrin
                                    : FontAwesomeIcons.solidKeyboard
                                    ,
                                    color: SColors.hint
                                  ),
                                ),
                                fillColor: Theme.of(context).scaffoldBackgroundColor,
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    width: 1.8,
                                    color: Theme.of(context).disabledColor,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColorDark,
                                    width: 1.8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).backgroundColor,
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              color: Scolors.info3,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: const [
                                SText(
                                  text: "Send to",
                                  color: SColors.black,
                                  weight: FontWeight.bold,
                                  size: 14
                                ),
                              ],
                            )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () => {},
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: SColors.lightPurple,
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: const Icon(
                                CupertinoIcons.paperplane_fill,
                                color: SColors.white,
                                size: 20
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  Widget fileWidget(PlatformFile file){
    final kb = file.size / 7024;
    final mb = kb / 1024;
    final fileSize = mb >= 1 ? "${mb.toStringAsFixed(2)} MB" : "${kb.toStringAsFixed(2)} KB";
    final extension = file.extension ?? "none";
    debugShow(file.identifier);
    final color = getExtensionColor(extension);

    return InkWell(
      // onTap: () => widget.onDependFile(file),
      onTap: () => OpenFilex.open(file.path),
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
}