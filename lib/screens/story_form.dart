import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plasmo/models/story_model.dart';
import 'package:plasmo/screens/bottom_navbar.dart';
import 'package:plasmo/screens/login_screen.dart';
import 'package:plasmo/screens/stories_screen.dart';
import 'package:plasmo/services/firebase/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:plasmo/provider/story_provider.dart';

class StoryForm extends StatefulWidget {
  static const routeName = '/story-screen';
  @override
  _StoryFormState createState() => _StoryFormState();
}

class _StoryFormState extends State<StoryForm> {
   final FirebaseAuth _auth = FirebaseAuth.instance;
    var user;
  final _storyFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();
  var _setStory = Story(name: null, story: null);

  Future<void> _saveForm() async {
    _form.currentState.save();
    print(_setStory.name);
    print(_setStory.story);
    try {
      if (_setStory.name.isEmpty || _setStory.story.isEmpty){
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

      await Provider.of<Stories>(context, listen: false).addStory(_setStory);
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Success'),
          content: Text('Thank you for sharing your story.'),
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
    } catch (e) {
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
              child: FutureBuilder(
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
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 25),
              Center(
                child: Text(
                  'Share your Success Story',
                  style: TextStyle(
                    color: Colors.green[400],
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 25),
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
                    FocusScope.of(context).requestFocus(_storyFocusNode);
                  },
                  onSaved: (value) {
                    _setStory = Story(
                      name: value,
                      story: _setStory.story,
                    );
                  }),
              TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Story",
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontFamily: 'Poppins',
                    ),
                  ),
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  focusNode: _storyFocusNode,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    _saveForm();
                  },
                  onSaved: (value) {
                    _setStory = Story(
                      name: _setStory.name,
                      story: value,
                    );
                  }),
              ElevatedButton(
                  onPressed: () => _saveForm(), child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
