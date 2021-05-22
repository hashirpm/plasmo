import 'package:flutter/material.dart';
import 'package:plasmo/screens/bottom_navbar.dart';
import 'package:plasmo/screens/home_screen.dart';
import 'package:plasmo/services/firebase/auth_services.dart';

import 'login_screen.dart';

class BannerScreen extends StatefulWidget {
  static const routeName = '/banner';

  @override
  _BannerScreenState createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text(
            'PLASMO',
            style: TextStyle(
              color: Colors.grey,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: TextButton(
          child: CircleAvatar(
            backgroundColor: Colors.orange,
            radius: 23,
            child: Icon(Icons.login, color: Colors.black),
          ),
          onPressed: () async {
            await AuthServices.signOut();
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            setState(() {
             
            });
          },
        ),
                actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: 
              Icon(
                Icons.person,
                color: Colors.black,
                size: 26.0,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      floatingActionButton:Padding(
        padding: EdgeInsets.all(100),
              child: FloatingActionButton.extended(onPressed: (){
        Navigator.of(context)
                        .pushReplacementNamed(BottomNavbar.routeName);
        }, label: Text('Skip'),icon: Icon(Icons.arrow_forward),
    backgroundColor: Colors.greenAccent,),
      ),
  floatingActionButtonLocation:    
      FloatingActionButtonLocation.miniCenterDocked,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image(
        
    
                            
                image: AssetImage('assets/images/covid-banner.png'),

                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                  
                

          )
             
           // Text('This is Banner'),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.of(context)
            //           .pushReplacementNamed(BottomNavbar.routeName);
            //     },
            //     child: Text('Skip'))
          ],
        ),
      ),
    );
  }
}
