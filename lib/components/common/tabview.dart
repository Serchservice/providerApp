import 'package:flutter/cupertino.dart';
import 'package:provide/lib.dart';

class STab extends StatelessWidget {
  final IconData? icon;
  final String tabText;
  final int index;
  final bool isSelected;
  final ValueChanged<int> onTap;
  const STab({
    super.key, this.icon, required this.index,this.isSelected = false, required this.onTap,
    required this.tabText
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isSelected ? SColors.lightPurple : null
        ),
        child: SText(
          text: tabText,
          size: 16,
          color: isSelected ? SColors.white : SColors.light
        )
      )
    );
  }
}