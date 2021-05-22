import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DonorCard extends StatelessWidget {
  //final int userId;
  final String userName;
  final String userPhone;
  final String userLocation;
  //final String userDP;
  final String userBlood;

  const DonorCard({
    //this.userId,
    this.userName,
    this.userPhone,
    this.userLocation,

    this.userBlood,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: 150.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(-4, 4),
            blurRadius: 10,
            color: Color(0xFF212121).withOpacity(.2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Icon(Icons.person)
                    //Image.asset(this.userDP),
                    ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 0, 8),
            child: Row(
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.userAstronaut,
                  size: 16.0,
                  color: Colors.orangeAccent,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  this.userName,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 8),
            child: Row(
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.searchLocation,
                  size: 16.0,
                  color: Colors.deepOrangeAccent,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  this.userLocation,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 2),
            child: Row(
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.heart,
                  size: 16.0,
                  color: Colors.deepOrange,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  this.userBlood,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 35.0,
                width: 35.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.green,
                ),
                child: new IconButton(
                  iconSize: 19.0,
                  icon: new Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    final url = "tel:${this.userPhone}";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
              ),
              SizedBox(
                width:25
              ),
              Container(
               
                  height: 35.0,
                width: 35.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.green,
                ),
       
                child: IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.whatsapp,
                    size: 19.0,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    final url = "whatsapp://send?phone=+91${this.userPhone}";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
