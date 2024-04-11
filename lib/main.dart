import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zypherion/login_screen.dart';
import 'package:zypherion/mobilescreen.dart';
import 'package:zypherion/responsive.dart';
import 'package:zypherion/themes.dart';
import 'package:zypherion/webscreen.dart';

import 'firebase_options.dart';

Future main()async {
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,

  );
// if(kIsWeb)
// {
//   WidgetsFlutterBinding.ensureInitialized();
//
// await Firebase.initializeApp(options:const FirebaseOptions(
//     apiKey: "AIzaSyCu4_PNmEQ1PL5w-U3tBV3h6B3r2kY1rCo",
//
//     authDomain: "esp82266-31379.firebaseapp.com",
//
//     databaseURL: "https://esp82266-31379-default-rtdb.firebaseio.com",
//
//     projectId: "esp82266-31379",
//
//     storageBucket: "esp82266-31379.appspot.com",
//
//     messagingSenderId: "101994278872",
//
//     appId: "1:101994278872:web:6e5bf5177d61ff9e754cad"
// ));
// }
// else{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
// }
  runApp(const MyApp());
}
User? user;
ToggleUser(User _user){
  user=_user;
  MyApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: darkGreenTheme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      
       builder: (context,snap){
       if(snap.connectionState==ConnectionState.waiting){
         return Center(child: CircularProgressIndicator(),);
       }else if(snap.hasError){return Text("Error");}
       else if(snap.hasData){
         return ResponsiveLay(mobileScreen: MobileScreenLayout(), webScreen: WebScreenLayout( email:user!=null?user!.email!:"",));
       }else{
         return LoginScreen();
       }
       }, stream: FirebaseAuth.instance.authStateChanges(),);
    // return ResponsiveLay(mobileScreen: MobileScreenLayout(), webScreen: WebScreenLayout());
  }
}
