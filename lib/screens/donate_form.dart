import 'package:flutter/material.dart';
import 'package:plasmo/models/donor_model.dart';
import 'package:plasmo/provider/donor_provider.dart';
import 'package:plasmo/screens/home_screen.dart';
import 'package:provider/provider.dart';

class DonateForm extends StatefulWidget {
  static const routeName = '/donate-screen';
  @override
  _DonateFormState createState() => _DonateFormState();
}

class _DonateFormState extends State<DonateForm> {
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
                  .pushReplacementNamed(HomeScreen.routeName);
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
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
