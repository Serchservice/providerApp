import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen({super.key});
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> with WidgetsBindingObserver, TickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: userProfileCount, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void onNavigationItemSelected(index) {
    widget.pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            CupertinoIcons.chevron_back,
            color: Theme.of(context).primaryColorLight,
            size: 28
          )
        ),
        actions: [
          IconButton(
            onPressed: () => deleteUser(
              context: context,
              onClick: () {
                Get.offUntil(GetPageRoute(page: () => const BottomNavigator(newPage: 1)), (route) => false);
              }
            ),
            icon: Icon(CupertinoIcons.delete, color: Theme.of(context).primaryColorLight),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: screenPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                children: const [
                  UserCallHeader(),
                  SizedBox(height: 20),
                ],
              ),
            )
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                // borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
              ),
              child: SChatTab(onItemSelected: onNavigationItemSelected,)
            ),
          ),
          ValueListenableBuilder(
            valueListenable: widget.pageIndex,
            builder: (BuildContext context, int value, _) {
              return userProfile[value];
            },
          ),
        ],
      ),
    );
  }
}

List<Widget> userProfile = [
  const UserProfileAll(),
  const UserProfileImages(),
  const UserProfileVideos()
];

int userProfileCount = userProfile.length;

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
    List<UserCallModel> allFilesList = [
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

class UserProfileImages extends StatefulWidget {
  const UserProfileImages({super.key});

  @override
  State<UserProfileImages> createState() => _UserProfileImagesState();
}

class _UserProfileImagesState extends State<UserProfileImages> {
  int count = 0;
  List<PlatformFile>? files;

  @override
  Widget build(BuildContext context) {
    List<UserCallModel> allFilesList = [
    ];

    if(files == null && allFilesList.isEmpty){
      return const SliverPadding(
        padding: EdgeInsets.all(100.0),
        sliver: SliverToBoxAdapter(
          child: Center(
            child: SText(
              text: "You have no image files",
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

class UserProfileVideos extends StatefulWidget {
  const UserProfileVideos({super.key});

  @override
  State<UserProfileVideos> createState() => _UserProfileVideosState();
}

class _UserProfileVideosState extends State<UserProfileVideos> {
  int count = 0;
  List<PlatformFile>? files;

  @override
  Widget build(BuildContext context) {
    List<UserCallModel> allFilesList = [
    ];

    if(files == null && allFilesList.isEmpty){
      return const SliverPadding(
        padding: EdgeInsets.all(100.0),
        sliver: SliverToBoxAdapter(
          child: Center(
            child: SText(
              text: "You have no video files",
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

void deleteUser({required BuildContext context, VoidCallback? onClick}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Theme.of(context).backgroundColor,
            elevation: 0,
            title: SText(text: "Are you sure you want to delete this user?.", color: Theme.of(context).primaryColor, size: 16),
            actions: [
              SBtn(
                text: "Delete", textSize: 16,
                buttonColor: Theme.of(context).backgroundColor,
                textColor: SColors.lightPurple,
                onClick: onClick
              ),
              SBtn(
                text: "Don't delete", textSize: 16,
                onClick: () => Navigator.of(context).pop(false),
                buttonColor: Theme.of(context).backgroundColor,
                textColor: SColors.lightPurple,
              )
            ],
          );
        }
      );
    }
  );
}

class SChatTab extends StatefulWidget {
  const SChatTab({super.key, required this.onItemSelected});
  final ValueChanged<int> onItemSelected;

  @override
  State<SChatTab> createState() => _SChatTabState();
}

class _SChatTabState extends State<SChatTab> {
  var selectedIndex = 0;
  void handleItemSelected(int index){
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            STab(
              tabText: "All files",
              // icon: CupertinoIcons.home,
              index: 0,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 0),
            ),
            STab(
              tabText: "Images",
              // icon: CupertinoIcons.chat_bubble_2_fill,
              index: 1,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 1),
            ),
            STab(
              tabText: "Videos",
              // icon: CupertinoIcons.phone,
              index: 2,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 2),
            ),
          ]
        ),
      );
  }
}