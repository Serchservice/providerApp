class Validators {
  static String? email(String? value) {
    if(value!.trim().isEmpty) {
      return "Email cannot be empty";
    } else if (!value.contains("@")){
      return "Email is incorrect";
    } else {
      return null;
    }
  }

  static String? password(String? value) {
    if(value!.trim().isEmpty) {
      return "Password cannot be empty";
    } else if (value.length < 6 ){
      return "Password is too short";
    } else {
      if( !value.contains(RegExp(r'[A-Z]')) ){
        return "You must have a capital letter";
      } else if( !value.contains(RegExp(r'[a-z]'))){
        return "You must have a small letter";
      } else if(!value.contains(RegExp(r'[0-9]'))){
        return "You must have a number";
      } else if(!value.contains(RegExp(r'[@-Z]'))){
        return "You must add a special character";
      } else {
        return null;
      }
    }
  }

  static String? string({String? emptyValue, String? incorrectValue, String? value}) {
    if(value!.trim().isEmpty) {
      return emptyValue;
    } else if (value.length < 3){
      return incorrectValue;
    } else {
      return null;
    }
  }

  static String? name(String? value) {
    if(value!.trim().isEmpty) {
      return "Name cannot be empty";
    } else if (value.length < 3){
      return "Name is incorrect";
    } else {
      return null;
    }
  }

  static String? gender(String? value) {
    if(value == null) {
      return "Please select a gender";
    } else {
      return null;
    }
  }

  static String? phone(String? value) {
    if(value!.trim().isEmpty) {
      return "Phone number cannot be empty";
    } else if (value.length != 11){
      return "Phone number is incorrect";
    } else {
      return null;
    }
  }
}

class AdditionalValidators{
  static String? streetNumber(String? value) {
    if(value!.isEmpty) {
      return "Number is empty";
    } else {
      return null;
    }
  }

  static String? streetName(String? value) {
    if(value!.isEmpty) {
      return "Please enter Street name";
    } else {
      return null;
    }
  }

  static String? userCity(String? value) {
    if(value!.isEmpty) {
      return "Please enter your city";
    } else {
      return null;
    }
  }

  static String? userState(String? value) {
    if(value!.isEmpty) {
      return "Please enter your state";
    } else {
      return null;
    }
  }

  static String? userCountry(String? value) {
    if(value!.isEmpty) {
      return "Please enter your country";
    } else {
      return null;
    }
  }

  static String? address(String? value) {
    if(value!.isEmpty) {
      return "Please enter your address";
    } else {
      return null;
    }
  }

  static String? title(String? value) {
    if(value== null) {
      return "Please select a title";
    } else {
      return null;
    }
  }

  static String? relation(String? value) {
    if(value!.isEmpty) {
      return "Please select relationship";
    } else {
      return null;
    }
  }
}