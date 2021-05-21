import 'package:flutter/material.dart';
import 'package:plasmo/models/story_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Stories with ChangeNotifier{
  List<Story> _stories =[];

  List<Story> get stories{
    return [..._stories];
  }
  Future addStory(Story story) async {
    const url = 'https://plasmo-4868e-default-rtdb.firebaseio.com/stories.json';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'name': story.name,
            'story': story.story,
          }));
      final newStory = Story(
        name: story.name,
        story: story.story,
     
        id: json.decode(response.body)['name'],
      );
      _stories.add(newStory);
      print(newStory.story);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
  Future<void> getAllStories() async {
    const url = 'https://plasmo-4868e-default-rtdb.firebaseio.com/stories.json';
    try {
      final response = await http.get(Uri.parse(url));
      
      final storyData = json.decode(response.body) as Map<String, dynamic>;
  
      if (storyData == null) {
        return;
      }
      final List<Story> storyList = [];
      storyData.forEach((id, data) {
        storyList.add(
          Story(
            id: id,
            name: data['name'],
            story: data['story']
            
        ));
      });
      _stories=storyList;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

}