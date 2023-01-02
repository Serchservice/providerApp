import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class TabWithImage extends StatelessWidget {
  final String settingHeader;
  final String? settingDetail;
  final String? image;
  final VoidCallback? onPressed;

  const TabWithImage({
    super.key,
    required this.settingHeader,
    this.settingDetail,
    this.image,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          children: [
            if(image == null)
            Container()
            else
            Image.asset(image!, width: 40),
            const SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SText(
                    text: settingHeader,
                    size: 16,
                    weight: FontWeight.bold,
                    color: Theme.of(context).primaryColorLight
                  ),
                  if(settingDetail == null)
                  Container()
                  else
                  SText(text: settingDetail!, color: SColors.hint,)
                ],
              )
            ),
            Icon(
              CupertinoIcons.chevron_right,
              size: 24,
              color: Theme.of(context).primaryColorLight
            )
          ],
        ),
      ),
    );
  }
}






class SetTab extends StatelessWidget {
  final String settingHeader;
  final String? settingDetail;
  final IconData? prefixIcon;
  final Color? iconColor;
  final VoidCallback? onPressed;
  final Widget? widget;

  const SetTab({
    super.key,
    required this.settingHeader,
    this.settingDetail,
    this.prefixIcon,
    this.onPressed,
    this.widget,
    this.iconColor
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      color: Theme.of(context).backgroundColor,
      child: InkWell(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              if(prefixIcon == null)
              Container()
              else
              Icon(prefixIcon!, color: iconColor ?? Theme.of(context).primaryColorLight, size: 28),
                const SizedBox(width: 10,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SText(
                      text: settingHeader,
                      size: 16,
                      weight: FontWeight.bold,
                      color: Theme.of(context).primaryColorLight
                    ),
                    if(settingDetail == null)
                    Container()
                    else
                    SText(text: settingDetail!, color: SColors.hint,)
                  ],
                )
              ),
              if(widget == null)
              Container()
              else
              widget!
            ],
          ),
        ),
      ),
    );
  }
}