import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plasmo/provider/donor_provider.dart';
import 'package:plasmo/provider/story_provider.dart';
import 'package:plasmo/screens/home_screen.dart';
import 'package:plasmo/screens/login_screen.dart';
import 'package:plasmo/screens/stories_screen.dart';
import 'package:plasmo/services/firebase/auth_services.dart';
import 'package:provider/provider.dart';

class BottomNavbar extends StatefulWidget {
  static const routeName = 'bottomNav_screen';
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {


  var _load = false;

  int _selectedPage = 0;
  void onTabChangedListener(position) {
    setState(() {
      _selectedPage = position;
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();

    fetchAllProps();
  }

  Future fetchAllProps() async {
    setState(() {
      _load = true;
    });
    await Provider.of<Donors>(context, listen: false).getAllDonors();
    await Provider.of<Stories>(context, listen: false).getAllStories();
    setState(() {
      _load = false;
    });
  }

  @override
  Widget build(BuildContext context) {



    List<Widget> widList = [HomeScreen(), StoriesScreen()];
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
            backgroundColor: Colors.white,
            radius: 23,
            child: Icon(Icons.login, color: Colors.black),
          ),
          onPressed: () async {
            await AuthServices.signOut();
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            setState(() {});
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
      body: _load
          ? Center(child: CircularProgressIndicator())
          : widList[_selectedPage],
      bottomNavigationBar: SizedBox(
        height: 58,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Theme.of(context).accentColor,
          selectedLabelStyle: TextStyle(
            fontSize: 10.2,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w300,
          ),
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Stories',
            ),
          ],
          currentIndex: _selectedPage,
          onTap: onTabChangedListener,
        ),
      ),
    );
  }
}
