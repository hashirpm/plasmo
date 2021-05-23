import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plasmo/provider/story_provider.dart';
import 'package:plasmo/screens/banner_screen.dart';
import 'package:plasmo/screens/bottom_navbar.dart';
import 'package:plasmo/screens/donate_form.dart';
import 'package:plasmo/screens/home_screen.dart';
import 'package:plasmo/screens/loading_screen.dart';
import 'package:plasmo/screens/login_screen.dart';
import 'package:plasmo/screens/signup_screen.dart';
import 'package:plasmo/screens/stories_screen.dart';
import 'package:plasmo/screens/story_form.dart';
import 'package:provider/provider.dart';
import 'package:plasmo/provider/donor_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
  

    //print(user);
    //});
    screen() async{
     var user=await _auth.currentUser();
        
        if (user != null) {
          print('here1');
          print(user);
          print(user != null);
          return BottomNavbar();
        }
        

      if (user == null) {
        print('here2');
          return LoginScreen();
        }
    }

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
        home: FutureBuilder(
        future: screen(),
        builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.done) {
            return (snapshot.data);
          }
        return LoadingScreen() ;
        },
      ),
        debugShowCheckedModeBanner: false,
        routes: {
          LoginScreen.routeName: (ctx) => LoginScreen(),
          SignUp.routeName: (ctx) => SignUp(),
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
