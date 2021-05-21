import 'package:flutter/material.dart';
import 'package:plasmo/models/donor_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Donors with ChangeNotifier {
  List<Donor> _donors = [];

  List<Donor> get donors{
    return [..._donors];
  }

  Future addDonor(Donor donor) async {
    const url = 'https://plasmo-4868e-default-rtdb.firebaseio.com/donors.json';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'name': donor.userName,
            'phone': donor.userPhone,
            'location': donor.userLocation,
            'blood': donor.userBlood
          }));
      final newDonor = Donor(
        userName: donor.userName,
        userPhone: donor.userPhone,
        userBlood: donor.userBlood,
        userLocation: donor.userLocation,
        userId: json.decode(response.body)['name'],
      );
      _donors.add(newDonor);
      print(newDonor.userId);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> getAllDonors() async {
    const url = 'https://plasmo-4868e-default-rtdb.firebaseio.com/donors.json';
    try {
      final response = await http.get(Uri.parse(url));
      
      final donorData = json.decode(response.body) as Map<String, dynamic>;
  
      if (donorData == null) {
        return;
      }
      final List<Donor> donorList = [];
      donorData.forEach((id, data) {
        donorList.add(
          Donor(
            userId: id,
            userName: data['name'],
            userBlood: data['blood'],
            userLocation: data['location'],
            userPhone: data['phone'],
          ),
        );
      });
      _donors=donorList;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
