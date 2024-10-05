import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/widgets/bottom_nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAXX_YKJXLzWDPil1VfSKipLe48_QNObRk",
          appId: "1:625218136457:android:3d004c10875c44f0669958",
          messagingSenderId: "625218136457",
          projectId: "wallpaper-app-55fad",
          storageBucket: "gs://wallpaper-app-55fad.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber)),
        debugShowCheckedModeBanner: false,
        home: BottomNav());
  }
}
