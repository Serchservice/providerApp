import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provide/lib.dart';
import 'package:provider/provider.dart';

class AvatarPicture extends StatelessWidget {
  final double radius;
  const AvatarPicture({super.key, required this.radius});

  const AvatarPicture.small({super.key}) : radius = 16;
  const AvatarPicture.medium({super.key}) : radius = 22;
  const AvatarPicture.large({super.key}) : radius = 40;

  @override
  Widget build(BuildContext context) {
    String gender = Provider.of<UserInformation>(context, listen: false).user.gender ?? "";
    String service = Provider.of<UserServiceInformation>(context, listen: false).service ?? "";
    return CircleAvatar(
      radius: radius,
      backgroundColor: SColors.lightPurple,
      foregroundImage: gender == "Male" && service == "Electrician"
      ? const AssetImage(SImages.manElectrician)

      : gender == "Female" && service == "Electrician"
      ? const AssetImage(SImages.womanElectrician)

      : gender == "Male" && service == "Plumber"
      ? const AssetImage(SImages.manPlumber)

      : gender == "Female" && service == "Plumber"
      ? const AssetImage(SImages.manPlumber)

      : gender == "Male" && service == "Mechanic"
      ? const AssetImage(SImages.manMechanic)

      : gender == "Female" && service == "Mechanic"
      ? const AssetImage(SImages.manMechanic)

      : gender == "Prefer Not to Say" && service == ""
      ? const AssetImage(SImages.noGender)

      : gender == "Male" && service == "Barber"
      ? const AssetImage(SImages.barberAvatar)

      : gender == "Female" && service == "Barber"
      ? const AssetImage(SImages.barberAvatar)

      : gender == "Prefer Not to say" && service == "Barber"
      ? const AssetImage(SImages.barberAvatar)

      : gender == "Male" && service == ""
      ? const AssetImage(SImages.man)

      : gender == "Female" && service == ""
      ? const AssetImage(SImages.woman)

      : const AssetImage(SImages.logo)
    );
  }
}

class SSPicture extends StatelessWidget {
  final double radius;
  const SSPicture({super.key, required this.radius});

  const SSPicture.small({super.key}) : radius = 12;
  const SSPicture.medium({super.key}) : radius = 22;
  const SSPicture.large({super.key}) : radius = 30;
  @override
  Widget build(BuildContext context) {
    String service = Provider.of<UserServiceInformation>(context, listen: false).service ?? "";
    String firstName = Provider.of<UserInformation>(context, listen: false).user.firstName ?? "";
    String lastName = Provider.of<UserInformation>(context, listen: false).user.lastName ?? "";
    String initials() {
      if(firstName.isEmpty || lastName.isEmpty){
        return "Eva";
      } else {
        return "${firstName.substring(0, 1)}${lastName.substring(0, 1)}";
      }
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: SColors.lightPurple,
      child: service == "Electrician"
      ? Image.asset(SImages.electric, width: radius, height: radius)

      : service == "Plumber"
      ? Image.asset(SImages.plumb, width: radius, height: radius)

      : service == "Mechanic"
      ? Image.asset(SImages.mech, width: radius, height: radius)

      : service == "Barber"
      ? Image.asset(SImages.barb, width: radius, height: radius)

      : Padding(
        padding: const EdgeInsets.all(8.0),
        child: SText(
          text: initials(),
          size: radius - 5,
          weight: FontWeight.bold
        ),
      )
    );
  }
}

class Avatar extends StatelessWidget {
  final String? image;
  final double radius;
  const Avatar({super.key, this.image, required this.radius});
  const Avatar.large({super.key, this.image}) : radius = 50;
  const Avatar.medium({super.key, this.image}) : radius = 30;
  const Avatar.small({super.key, this.image}) : radius = 20;

  @override
  Widget build(BuildContext context) {
    if(image == null || image!.isEmpty) {
      return AvatarPicture(radius: radius);
    } else {
      final imagePath = image!;
      final userImage = imagePath.contains("https://") ? NetworkImage(imagePath) : FileImage(File(imagePath));
      return CircleAvatar(
        radius: radius,
        backgroundColor: SColors.lightPurple,
        foregroundImage: userImage as ImageProvider
      );
    }
  }
}

class ImageWidget extends StatelessWidget {
  final File image;
  final ValueChanged<ImageSource> onClick;
  const ImageWidget({super.key, required this.image, required this.onClick});

  @override
  Widget build(BuildContext context) {
    final imagePath = this.image.path;
    final image = imagePath.contains("https://") ? NetworkImage(imagePath) : FileImage(File(imagePath));
    return Material(
      child: InkWell(
        onTap: () async {
          final source = await showImageSource(context);
          if(source == null) return;
          onClick(source);
        },
        child: Ink.image(image: image as ImageProvider)
      )
    );
  }
}

//For the User
class Picture extends StatelessWidget {
  final double radius;
  const Picture({super.key, required this.radius});

  const Picture.small({super.key}) : radius = 16;
  const Picture.medium({super.key}) : radius = 22;
  const Picture.large({super.key}) : radius = 30;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      foregroundImage: const AssetImage(SImages.manElectrician)
    );
  }
}