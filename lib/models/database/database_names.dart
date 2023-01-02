import 'package:provide/lib.dart';

class MainDB{
  // final user = FbAuth().currentUser;
  // final CollectionReference clients = FirebaseFirestore.instance.collection("clients");
  // final CollectionReference providers = FirebaseFirestore.instance.collection("providers");
}

class SecondDB{
  static const profile = "profile";
  static const referrals = "referrals";
  static const ratings = "ratings";
  static const connection = "connection";
}

class ProfileDB{
  static const detail = "details";
  static const service = "service";
  static const additional = "additional";
}

class RatingDB{
  static const good = "good_ratings";
  static const bad = "bad_ratings";
  static const summary = "summary";
}

class ConnectionDB{
  static const history = "history";
  static const requests = "requests";
  static const ongoing = "ongoing";
}