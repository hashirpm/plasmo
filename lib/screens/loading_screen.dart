import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  static const routeName = '/loading-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
        child: Center(child: CircularProgressIndicator()),
        
      ),
    );
  }
}