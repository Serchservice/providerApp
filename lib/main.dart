import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provide/lib.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    // TODO: Replace credentials with your own
    url: supabaseUrl,
    anonKey: supabaseAnon,
  );
  await GetStorage.init();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: GetMaterialApp(
        themeMode: UserSharedPermits().getThemeMode(),
        theme: STheme.light(),
        darkTheme: STheme.dark(),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen()
      ),
    );
  }
}