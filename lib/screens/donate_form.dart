import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plasmo/models/donor_model.dart';
import 'package:plasmo/provider/donor_provider.dart';
import 'package:plasmo/screens/bottom_navbar.dart';
import 'package:plasmo/screens/home_screen.dart';
import 'package:plasmo/services/firebase/auth_services.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class DonateForm extends StatefulWidget {
  static const routeName = '/donate-screen';
  @override
  _DonateFormState createState() => _DonateFormState();
}

class _DonateFormState extends State<DonateForm> {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var user;
  //final _nameFocusNode = FocusNode();
  final _bloodFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();
  var _setDonor=Donor(userName: null,userBlood: null,userLocation: null,userPhone: null);

  Future <void>_saveForm()async{
    _form.currentState.save();
    // print(_setDonor.userName);
    //  print(_setDonor.userBlood);
    //   print(_setDonor.userPhone);
    //    print(_setDonor.userLocation);
    try{
         if (_setDonor.userName.isEmpty || _setDonor.userBlood.isEmpty||_setDonor.userPhone.isEmpty||_setDonor.userLocation.isEmpty){
      return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Sorry'),
          content: Text('The fields are empty'),
          actions: <Widget>[
            new ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // dismisses only the dialog and returns nothing
              },
              child: new Text('OK'),
            ),
          ],
        ),
      );
      }
      await Provider.of<Donors>(context,listen: false).addDonor(_setDonor);
      await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Success'),
        content: Text(
                'Thank you for donating your plasma.'),
        actions: <Widget>[
          new ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(BottomNavbar.routeName);
                // dismisses only the dialog and returns nothing
            },
            child: new Text('OK'),
          ),
        ],
      ),
    );
//     AlertDialog(
//     title: Text("Success"),
//     content: Text("Thank you donating your Plasma."),
//     actions: [
//       ElevatedButton(
//     child: Text("OK"),
//     onPressed: () {
// Navigator.of(context).pop();
//      },
//     )
//     ],
//   );

    }catch(e){
      print(e);
    }
    
  }
   userImg() async {
    user = await _auth.currentUser();

    if (this.user.photoUrl != null) {
      print('truehere');
      return this.user.photoUrl;
    }

    print('falsehere');
    return false;
    //{"res":false,"val":null};
  }

  getUserImg() {
    _auth.currentUser().then((res) {
      return res.photoUrl;
    });
  }

   @override
  void dispose() {
    _bloodFocusNode.dispose();
    _locationFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }
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
            backgroundColor: Colors.white,
            radius: 23,
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
          onPressed: () async {
            await AuthServices.signOut();
            Navigator.of(context).pop();
         
          },
        ),
                actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: 
              FutureBuilder(
                future: userImg(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.data == false
                        ? Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 26.0,
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data));
                  }

                  return Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 26.0,
                  );
                },
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
                        SizedBox(
              height:25
            ),
            Center(
          child: Text(
            'Donate a life',
            style: TextStyle(
              color: Colors.green[400],
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
         SizedBox(
              height:25
            ),
              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Name",
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontFamily: 'Poppins',
                  ),
                ),
                textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_bloodFocusNode);
                    },
                    onSaved: (value) {
                 
                      _setDonor=Donor(
                        userName: value,
                        userBlood: _setDonor.userBlood,
                        userPhone: _setDonor.userPhone,
                        userLocation: _setDonor.userLocation,
                      );
                    }
              ),
              // Container(
              //   padding: EdgeInsets.all(8.0),
              //   decoration: BoxDecoration(
              //     border: Border(
              //       bottom: BorderSide(
              //         color: Color(0xFFFFBF05).withOpacity(.10),
              //       ),
              //     ),
              //   ),
              //   child: 
                TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Blood Group",
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontFamily: 'Poppins',
                    ),
                  ),
                  focusNode: _bloodFocusNode,
                   textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_phoneFocusNode);
                    },
                    onSaved: (value) {
                      _setDonor=Donor(
                        userName: _setDonor.userName,
                        userBlood: value,
                        userPhone: _setDonor.userPhone,
                        userLocation: _setDonor.userLocation,
                      );
                    }
                ),
              //),
              // Container(
              //   padding: EdgeInsets.all(8.0),
              //   decoration: BoxDecoration(
              //     border: Border(
              //       bottom: BorderSide(
              //         color: Color(0xFFFFBF05).withOpacity(.10),
              //       ),
              //     ),
              //   ),
              //   child: 
                TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Phone number",
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontFamily: 'Poppins',
                    ),
                  ),
                   keyboardType: TextInputType.number,
                   focusNode: _phoneFocusNode,
                   textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_locationFocusNode);
                    },
                    onSaved: (value) {
                      _setDonor=Donor(
                        userName: _setDonor.userName,
                        userBlood: _setDonor.userBlood,
                        userPhone: value,
                        userLocation: _setDonor.userLocation,
                      );
                    }
                ),
             // ),
              // Container(
              //   padding: EdgeInsets.all(8.0),
              //   child: 
                TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Location",
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontFamily: 'Poppins',
                    ),
                  ),
                             textInputAction: TextInputAction.next,
                             focusNode: _locationFocusNode,
                    onFieldSubmitted: (_) {
                     _saveForm();
                    },
                    onSaved: (value) {
                      _setDonor=Donor(
                        userName: _setDonor.userName,
                        userBlood: _setDonor.userBlood,
                        userPhone: _setDonor.userPhone,
                        userLocation:value,
                      );
                    }
                ),
             // )
            ElevatedButton(
                    onPressed: () => _saveForm(), child: Text('Submit'))],
          ),
        ),
      ),
    );
  }
}
