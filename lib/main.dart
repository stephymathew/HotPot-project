import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hotpotproject/controller/hive/product_hive.dart';
//import 'package:hotpotproject/controller/firebase/product_service/product_service.dart';
//import 'package:hotpotproject/admin/home2.dart';
import 'package:hotpotproject/firebase_options.dart';
import 'package:hotpotproject/model/hive_model.dart';

import 'package:hotpotproject/views/splash/splash.dart';

// import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(ProductsAdapter().typeId)) {
    Hive.registerAdapter(ProductsAdapter());
  }
  await CartRepository.getCart();
  runApp(const HotPot());
}

class HotPot extends StatelessWidget {
  const HotPot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HotPot',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const CircularProgressIndicator()
              : snapshot.hasData
                  ? const SplashScreen(logOrNot: true)
                  : const SplashScreen(logOrNot: false);
        },
      ),
      // home: Home2Screen(),
    );
  }
}
