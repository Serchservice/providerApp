import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provide/lib.dart';

// class SSPicture extends StatelessWidget {
//   final double radius;
//   const SSPicture({super.key, required this.radius});

//   const SSPicture.small({super.key}) : radius = 12;
//   const SSPicture.medium({super.key}) : radius = 22;
//   const SSPicture.large({super.key}) : radius = 30;
//   @override
//   Widget build(BuildContext context) {
//     String service = Provider.of<UserServiceInformation>(context, listen: false).model.service ?? "";
//     String firstName = "Provider.of<UserInformation>(context, listen: false).user.firstName ?? """;
//     String lastName = "Provider.of<UserInformation>(context, listen: false).user.lastName ?? """;
//     String initials() {
//       if(firstName.isEmpty || lastName.isEmpty){
//         return "Eva";
//       } else {
//         return "${firstName.substring(0, 1)}${lastName.substring(0, 1)}";
//       }
//     }

//     return CircleAvatar(
//       radius: radius,
//       backgroundColor: SColors.lightPurple,
//       child: service == "Electrician"
//       ? Image.asset(SImages.electric, width: radius, height: radius)

//       : service == "Plumber"
//       ? Image.asset(SImages.plumb, width: radius, height: radius)

//       : service == "Mechanic"
//       ? Image.asset(SImages.mech, width: radius, height: radius)

//       : service == "Barber"
//       ? Image.asset(SImages.barb, width: radius, height: radius)

//       : Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SText(
//           text: initials(),
//           size: radius - 5,
//           weight: FontWeight.bold
//         ),
//       )
//     );
//   }
// }

class Avatar extends StatelessWidget {
  final UserInformationModel userInformationModel;
  final double radius;
  final VoidCallback? onClick;
  const Avatar({
    super.key, required this.radius, this.userInformationModel = const UserInformationModel(), this.onClick
  });
  const Avatar.large({
    super.key, this.userInformationModel = const UserInformationModel(), this.onClick
  }) : radius = 50;
  const Avatar.medium({
    super.key, this.userInformationModel = const UserInformationModel(), this.onClick
  }) : radius = 30;
  const Avatar.small({
    super.key, this.userInformationModel = const UserInformationModel(), this.onClick
  }) : radius = 20;

  @override
  Widget build(BuildContext context) {
    final imagePath = userInformationModel.avatar;
    final userImage = imagePath.contains("https://") ? NetworkImage(imagePath)
    : imagePath.startsWith("/") ? FileImage(File(imagePath)) : AssetImage(
      userInformationModel.service == "Electrician" ? SImages.manElectrician
      : userInformationModel.gender == "Female" && userInformationModel.service == "Electrician" ? SImages.womanElectrician
      : userInformationModel.service == "Plumber" ? SImages.manPlumber
      : userInformationModel.gender == "Female" && userInformationModel.service == "Plumber" ? SImages.manPlumber
      : userInformationModel.service == "Mechanic" ? SImages.manMechanic
      : userInformationModel.gender == "Female" && userInformationModel.service == "Mechanic" ? SImages.manMechanic
      : userInformationModel.gender == "Prefer Not to Say" && userInformationModel.service == "" ? SImages.noGender
      : userInformationModel.gender == "Female" && userInformationModel.service == "" ? SImages.woman
      : SImages.man
    );
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onClick,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: SColors.lightPurple,
          foregroundImage: userImage as ImageProvider
        ),
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  final String image;
  final double radius;
  const UserAvatar({super.key, this.image = "", required this.radius});
  const UserAvatar.large({super.key, this.image = ""}) : radius = 50;
  const UserAvatar.medium({super.key, this.image = ""}) : radius = 30;
  const UserAvatar.small({super.key, this.image = ""}) : radius = 20;

  @override
  Widget build(BuildContext context) {
    if(image.isEmpty) {
      return CircleAvatar(
        radius: radius,
        foregroundImage: const AssetImage(SImages.noGender)
      );
    } else {
      final imagePath = image;
      final userImage = imagePath.contains("https://") ? NetworkImage(imagePath)
      : imagePath.startsWith("/") ? FileImage(File(imagePath)) : AssetImage(imagePath);
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