import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class UserProfileAll extends StatelessWidget {
  const UserProfileAll({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: const Center(
        child: SText(
          text: "You have no shared files",
          color: SColors.hint,
          size: 18,
        ),
      ),
    );
  }
}