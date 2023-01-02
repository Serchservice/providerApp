import 'package:provide/lib.dart';

final Uri launchInstagram = Uri(scheme: "https", host: "www.instagram.com", path: "serchservice/");

final Uri launchLinkedIn = Uri(scheme: "https", host: "www.linkedin.com", path: "company/serchservice/");

final Uri launchFacebook = Uri(scheme: "https", host: "web.facebook.com", path: "serchservice/");

final Uri launchTwitter = Uri(scheme: "https", host: "www.twitter.com", path: "serchservice/");

final Uri launchYoutube = Uri(scheme: "https", host: "www.youtube.com", path: "@serchservice/");


final Uri launchSignIn = Uri(scheme: "https", host: "www.serchservice.com", path: "/");

final Uri launchSignUp = Uri(scheme: "https", host: "www.serchservice.com", path: "/");

final Uri launchPlans = Uri(scheme: "https", host: "www.serchservice.com", path: "/");

final Uri launchLocation = Uri(scheme: "https", host: "www.serchservice.com", path: "/");

final Uri policies = Uri(
  scheme: "https",
  host: "serchservice.com",
  path: "/",
  query: encodeQueryParameters(<String, String>{
      'subject': 'Example Subject & Symbols are allowed!',
    }),
);

final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'smith@example.com',
    query: encodeQueryParameters(<String, String>{
      'subject': 'Example Subject & Symbols are allowed!',
    }),
  );

final Uri smsLaunchUri = Uri(
  scheme: 'sms',
  path: '0118 999 881 999 119 7253',
  queryParameters: <String, String>{
    'body': Uri.encodeComponent('Example Subject & Symbols are allowed!'),
  },
);

const serverLink = "http://192.168.43.113:5000";