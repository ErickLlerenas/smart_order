import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_order/providers/app_provider.dart';
import 'package:smart_order/screens/home.dart';
import 'package:smart_order/screens/login/login.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>AppProvider())
  ],child: MyApp(),));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Order',
      initialRoute: '/login',
      routes: {
        '/login': (context) => Login(),
        '/home': (context) =>  Home(),
      },
    );
  }
}
