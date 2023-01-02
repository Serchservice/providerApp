import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SRes.isPhone(context)
      ? SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(topRight: Radius.circular(160))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        SImages.logo,
                        width: 40,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                const SignupForm()
              ],
            )
          ),
        ),
      )
      : Column()
    );
  }
}