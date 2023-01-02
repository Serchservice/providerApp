import 'package:flutter/cupertino.dart';

const int desktopDevice = 1366;
const int tabletDevice = 768;
const int phoneDevice = 480;

class SResponsive {
  static bool isPhone(BuildContext context) =>
    MediaQuery.of(context).size.width < phoneDevice;

  static bool isTablet(BuildContext context) =>
    MediaQuery.of(context).size.width >= tabletDevice &&
    MediaQuery.of(context).size.width < desktopDevice;

  static bool isDesktop(BuildContext context) =>
    MediaQuery.of(context).size.width > desktopDevice;
}

class SRes extends StatelessWidget{
  final Widget desktop;
  final Widget tablet;
  final Widget phone;

  const SRes({
    Key? key,
    required this.desktop,
    required this.phone,
    required this.tablet
  }) : super(key: key);

  static bool isPhone(BuildContext context) =>
    MediaQuery.of(context).size.width < phoneDevice;

  static bool isTablet(BuildContext context) =>
    MediaQuery.of(context).size.width >= tabletDevice &&
    MediaQuery.of(context).size.width < desktopDevice;

  static bool isDesktop(BuildContext context) =>
    MediaQuery.of(context).size.width > desktopDevice;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:(context, constraints) {
        double width = constraints.maxWidth;
        if(width >= desktopDevice){
          return desktop;
        } else if(width < desktopDevice && width >= phoneDevice){
          return tablet;
        }else {
          return phone;
        }
      },
    );
  }
}