import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class BookmarkerScreen extends StatefulWidget {
  const BookmarkerScreen({super.key});

  @override
  State<BookmarkerScreen> createState() => _BookmarkerScreenState();
}

class _BookmarkerScreenState extends State<BookmarkerScreen> {
  List<UserBookmarkModel> userBookmarks = HiveUserDatabase().getBookmarkDataList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            elevation: 0.5,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                CupertinoIcons.chevron_back,
                color: Theme.of(context).primaryColorLight,
                size: 28
              )
            ),
            title: SText(
              text: "My Bookmarkers",
              color: Theme.of(context).primaryColorLight,
              size: 30,
              weight: FontWeight.bold
            ),
            expandedHeight: 200,
          ),
          if(userBookmarks.isNotEmpty)
          SliverPadding(
            padding: screenPadding,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return BookmarkBox(model: userBookmarks[index]);
                }
              )
            )
          )
          else
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 200.0),
            sliver: SliverToBoxAdapter(
              child: Center(child: SText(text: "You have no bookmarkers", color: Theme.of(context).primaryColorLight, size: 20)),
            ),
          )
        ],
      )
    );
  }
}

class BookmarkBox extends StatelessWidget {
  final UserBookmarkModel model;
  const BookmarkBox({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserAvatar.small(image: model.image),
              const SizedBox(width: 10),
              SText(
                text: "${model.firstName} ${model.lastName}",
                color: Theme.of(context).primaryColorLight, size: 18
              ),
            ],
          ),
          const Icon(
            Icons.bookmark_added_rounded,
            size: 24, color:Scolors.success,
          )
        ],
      ),
    );
  }
}