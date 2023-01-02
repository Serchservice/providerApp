import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class Bookmarked extends StatefulWidget {
  final String name;
  final String distance;
  bool bookmarked;
  Bookmarked({super.key, required this.name, required this.distance, this.bookmarked = true});

  @override
  State<Bookmarked> createState() => _BookmarkedState();
}

class _BookmarkedState extends State<Bookmarked> {
  bookmark(){
    if(widget.bookmarked){
      setState(() => widget.bookmarked = !widget.bookmarked);
    }
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() => showProviderProfile(
        context: context,
        distance: widget.distance,
        tripCount: "4",
        name: widget.name
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Picture.medium(),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SText(text: widget.name, color: Theme.of(context).primaryColorLight, size: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 14),
                          SizedBox(width: 1),
                          Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 14),
                          SizedBox(width: 1),
                          Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 14),
                          SizedBox(width: 1),
                          Icon(CupertinoIcons.star_fill, color: SColors.rate, size: 14),
                          SizedBox(width: 1),
                          Icon(CupertinoIcons.star_lefthalf_fill, color: SColors.rate, size: 14),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SText(text: widget.distance, color: SColors.hint, size: 16),
                      InkWell(
                        onTap: () => bookmark(),
                        child: Icon(
                          widget.bookmarked ? CupertinoIcons.bookmark_solid : CupertinoIcons.bookmark_fill,
                          color: SColors.lightPurple,
                          size: 20
                        ),
                      )
                    ]
                  )
                ],
              ),
            ),
          ],
        )
      )
    );
  }
}