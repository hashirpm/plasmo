import 'package:flutter/material.dart';
import 'package:plasmo/provider/donor_provider.dart';
import 'package:plasmo/provider/story_provider.dart';
import 'package:plasmo/screens/story_form.dart';
import 'package:plasmo/widgets/story_card.dart';
import 'package:provider/provider.dart';

class StoriesScreen extends StatefulWidget {
  static const routeName = '/stories-screen';

  @override
  _StoriesScreenState createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  var _load = false;
  @override
  

  @override
  Widget build(BuildContext context) {
    final stories = Provider.of<Stories>(context).stories;
    return Scaffold(
            backgroundColor: Colors.white,
      floatingActionButton:FloatingActionButton.extended(onPressed: (){
        Navigator.of(context).pushNamed(StoryForm.routeName);
      }, label: Text('Story'),icon: Icon(Icons.add),
    backgroundColor: Colors.greenAccent,),
  floatingActionButtonLocation:    
      FloatingActionButtonLocation.centerFloat,
      resizeToAvoidBottomInset: false,
    
      body:
           Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.of(context).pushNamed(StoryForm.routeName);
                  //   },
                  //   child: Text('Share my Story'),
                  // ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(20.0),
                      itemCount: stories.length,
                      itemBuilder: (ctx, i) {
                        return Column(children: [
                          StoryCard(
                              name: stories[i].name, story: stories[i].story),
                          SizedBox(
                            height: 15,
                          )
                        ]);
                      },
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                    ),
                  ),
                ],
              ),
            ),
      //  Container(
      //   height: 50,
      //     padding: EdgeInsets.all(20),
      //     child: Column(
      //       children: [
      //         TextButton(
      //           onPressed: () {
      //             Navigator.of(context).pushNamed(StoryForm.routeName);
      //           },
      //           child: Text('Share my Story'),
      //         ),
      //         ListView.builder(
      //           itemCount: stories.length,
      //           itemBuilder: (ctx, i) {
      //             return StoryCard(
      //               name: stories[i].name,
      //               story: stories[i].story,
      //             );
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
    );
  }
}
