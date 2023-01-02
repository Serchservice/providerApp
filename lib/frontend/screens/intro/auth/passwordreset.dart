import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provide/lib.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SRes.isPhone(context)
      ? SafeArea(
        child: SingleChildScrollView(
          child: Column(
              children: [
                Padding(
                  padding: horizontalPadding,
                  child: Lottie.network(
                    "https://assets5.lottiefiles.com/packages/lf20_ulck7tah.json",
                    height: 200,
                  )
                ),
                const ResetPasswordForm()
              ]
          )
        )
      )
      : Column()
    );
  }
}