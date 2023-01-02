import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class AddressListTile extends StatelessWidget {
  final String maintext;
  final String secondarytext;
  final void Function()? onClick;
  const AddressListTile({super.key, required this.maintext, required this.secondarytext, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(
                CupertinoIcons.map_pin,
                color: SColors.yellow,
                size: 20
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SText(
                      text: maintext,
                      color: Theme.of(context).primaryColor,
                      flow: TextOverflow.ellipsis,
                      size: 18,
                    ),
                    const SizedBox(height: 3),
                    SText(
                      text: secondarytext,
                      flow: TextOverflow.ellipsis,
                      color: Theme.of(context).primaryColor,
                      size: 16
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}