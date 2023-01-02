import 'package:provider/provider.dart';
import 'package:provide/lib.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
  ChangeNotifierProvider(create: (_) => Auth()),
  ChangeNotifierProvider(create: (_) => UserInformation()),
  ChangeNotifierProvider(create: (_) => UserAdditionalInformation()),
  ChangeNotifierProvider(create: (_) => UserMapInformation()),
  ChangeNotifierProvider(create: (_) => UserScheduleList()),
  ChangeNotifierProvider(create: (_) => UserServiceInformation()),
  ChangeNotifierProvider(create: (_) => UserRatingInformation()),
  ChangeNotifierProvider(create: (_) => UserMoneyInformation()),
  ChangeNotifierProvider(create: (_) => UserServiceTripInformation()),
  ChangeNotifierProvider(create: (_) => UserChatsInformation()),
  ChangeNotifierProvider(create: (_) => UserChattingInformation()),
  ChangeNotifierProvider(create: (_) => UserPermissionInformation()),
];