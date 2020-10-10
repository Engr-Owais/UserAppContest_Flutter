import 'package:contest_user_app/Screens/OnGoingContest.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CONTEST',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: new SplashScreen(
            seconds: 4,
            navigateAfterSeconds: OnGoingContest(),
            title: new Text('Welcome To Contestor',
                style: GoogleFonts.abel(
                    fontWeight: FontWeight.bold, fontSize: 20)),
            image: new Image(
              image: AssetImage("assets/buffersplash.png"),
            ),
            backgroundColor: Colors.amber,
            styleTextUnderTheLoader: new TextStyle(),
            photoSize: 100,
            loaderColor: Colors.red));
  }
}
