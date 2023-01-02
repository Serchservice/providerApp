import 'dart:math';

import 'package:uuid/uuid.dart';

bool isNumeric(String s) => s.isNotEmpty && double.tryParse(s) != null;

class CodeGenerator {
  static Random random = Random();
  var uniqueID = const Uuid();

  static String generateCode(String prefix) {
    var id = random.nextInt(92143543) + 4356;
    return '$prefix${id.toString().substring(0, 4)}';
  }

  static String generateUniqueID(){
    var uniqueID = const Uuid();
    var unique = uniqueID.v4();
    return 'SerchID-$unique';
  }

//   static const uniqueID = Uuid();

//   static String serchID(prefix="Serch-ID-"){
//     const small_id = uniqueID.;
//     return `${prefix}${small_id}`;
// }

  static String generateUID(){
    const prefix = "Serch-ID-";
    const length = 15;
    const lowerCase = "abcdefghijklmnopqrstuvwxyz";
    const upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const numbers = "0123456789";
    //const special = "!@#\$%^&*()_+=-.,/><';:\"][{}]";

    String code = "";
    code += "$prefix$upperCase$lowerCase$numbers";

    return List.generate(length, (index) {
      final random = Random.secure().nextInt(code.length);
      return code[random];
    }).join('');
  }
}