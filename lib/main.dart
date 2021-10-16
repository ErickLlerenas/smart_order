import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_order/providers/app_provider.dart';
import 'package:smart_order/providers/login_provider.dart';
import 'package:smart_order/screens/home.dart';
import 'package:smart_order/screens/loading_screen.dart';
import 'package:smart_order/screens/login/login.dart';

import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppProvider()),
      ChangeNotifierProvider(create: (_) => LoginProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  bool isLoading = true;

  @override
  void initState() {
    Provider.of<AppProvider>(context, listen: false).readPhone().then((_phone) {
      if (_phone.isEmpty) {
        setState(() {
          isLoggedIn = false;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoggedIn = true;
          isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smart Order',
        home: isLoading
            ? LoadingScreen()
            : isLoggedIn
                ? Home()
                : Login());
  }
}
