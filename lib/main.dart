import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plasmo/provider/story_provider.dart';
import 'package:plasmo/screens/banner_screen.dart';
import 'package:plasmo/screens/bottom_navbar.dart';
import 'package:plasmo/screens/donate_form.dart';
import 'package:plasmo/screens/home_screen.dart';
import 'package:plasmo/screens/login_screen.dart';
import 'package:plasmo/screens/stories_screen.dart';
import 'package:plasmo/screens/story_form.dart';
import 'package:provider/provider.dart';
import 'package:plasmo/provider/donor_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var user;
    _auth.currentUser().then((value) {
      user = value;
    });

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Donors()),
        ChangeNotifierProvider(create: (_) => Stories()),
      ],
      child: MaterialApp(
        title: 'Plasmo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: user != null ? BottomNavbar() : LoginScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          LoginScreen.routeName: (ctx) => LoginScreen(),
          BannerScreen.routeName: (ctx) => BannerScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          DonateForm.routeName: (ctx) => DonateForm(),
          StoriesScreen.routeName: (ctx) => StoriesScreen(),
          StoryForm.routeName: (ctx) => StoryForm(),
          BottomNavbar.routeName: (ctx) => BottomNavbar(),
        },
      ),
    );
  }
}
