import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class FlexibleAppbar extends StatelessWidget {
  final bool backButton;
  final bool searchButton;
  final String headerText;
  const FlexibleAppbar({super.key, required this.backButton, required this.searchButton, required this.headerText});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(backButton == false)
            Container()
            else
            IconButton(
              onPressed: (){},
              icon: Icon(
                CupertinoIcons.chevron_back,
                color: Theme.of(context).primaryColorLight,
                size: 28
              )
            ),
            const SizedBox(width: 10),
            SText(
              text: headerText,
              color: Theme.of(context).primaryColor,
              size: 50,
              weight: FontWeight.bold
            ),
          ],
        ),
        if(searchButton == true)
        IconButton(
          onPressed: (){},
          icon: const Icon(
            CupertinoIcons.search_circle_fill,
            color: SColors.light,
            size: 28
          )
        )
        else
        Container()
      ],
    );
  }
}