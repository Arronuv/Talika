import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talika/Screens/home.dart';
import 'package:talika/Screens/splash.dart';

import 'Themes/theme.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Talika',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      routes: {
        '/' : (context) =>const SplashScreen(),
        'home':(context) => const HomeScreen(),
      },
      initialRoute: '/',
    );
  }
}

