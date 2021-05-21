import 'package:flutter/material.dart';
import 'package:plasmo/screens/bottom_navbar.dart';
import 'package:plasmo/screens/home_screen.dart';

class BannerScreen extends StatelessWidget {
  static const routeName = '/banner';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is Banner'),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(BottomNavbar.routeName);
                },
                child: Text('Skip'))
          ],
        ),
      ),
    );
  }
}
