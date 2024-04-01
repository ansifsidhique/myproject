import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:myproject/Screens/mySplashScreen.dart';

import 'package:myproject/firebase_options.dart';
import 'package:myproject/provider/provider.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'package:provider/provider.dart';

void main() async {
  await PersistentShoppingCart().init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainScreenNotifier())
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData.light(),
            // theme: ThemeData(
            //   // backgroundColor: Colors.grey.shade500,
            //   // colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            //   useMaterial3: true,
            // ),
            home: const MySplash(),
          );
        }
      ),
    );
  }
}
