import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StoryCard extends StatelessWidget {
  final String name;
  final String story;


  const StoryCard({
    //this.userId,
    this.name,
    this.story,

  });
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200.0,
      // width: 350.0,
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
              SizedBox(
                width: 5.0,
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
                  this.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
           Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 0, 8),
            child: Container(
 
                          child: Row(
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.book,
                    size: 16.0,
                    color: Colors.orangeAccent,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Flexible(
                                      child: Text(
                      this.story,
                      softWrap: false,
                        maxLines: 15,
                       overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        
         
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
