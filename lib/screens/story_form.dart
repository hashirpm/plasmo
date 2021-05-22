import 'package:flutter/material.dart';
import 'package:plasmo/models/story_model.dart';
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
  final _storyFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();
  var _setStory = Story(name: null, story: null);

  Future<void> _saveForm() async {
    _form.currentState.save();
    print(_setStory.name);
    print(_setStory.story);
    try {
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
                    .pushReplacementNamed(StoriesScreen.routeName);
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
        backgroundColor: Colors.white,
      ),
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
