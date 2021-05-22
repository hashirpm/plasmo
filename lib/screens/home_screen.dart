import 'package:flutter/material.dart';
import 'package:plasmo/screens/donate_form.dart';
import 'package:plasmo/screens/login_screen.dart';
import 'package:plasmo/screens/stories_screen.dart';
import 'package:plasmo/services/firebase/auth_services.dart';
import 'package:plasmo/widgets/donor_card.dart';
import 'package:provider/provider.dart';
import 'package:plasmo/provider/donor_provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _load = false;
  @override
  @override
  Widget build(BuildContext context) {
    final donors = Provider.of<Donors>(context).donors;
    print(donors.length);
    var ButtonStyles;
    return Scaffold(
            backgroundColor: Colors.white,
      floatingActionButton:FloatingActionButton.extended(onPressed: (){
        Navigator.of(context).pushNamed(DonateForm.routeName);
      }, label: Text('Donate'),icon: Icon(Icons.add),
    backgroundColor: Colors.greenAccent,),
  floatingActionButtonLocation:    
      FloatingActionButtonLocation.centerFloat,
      
      body:
          // Container(
          //   padding: EdgeInsets.all(10),
          //   child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          //     TextButton(onPressed: (){
          //                         Navigator.of(context)
          //                 .pushNamed(DonateForm.routeName);

          //     }, child: Text('Donate')),DonorCard(
          //       userName: 'Hashir',
          //       userPhone: "9745252970",
          //       userLocation: 'Kozhikode',
          //       userBlood: "O+",
          //     )
          //   ]),
          // ),

          Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height:25
            ),
            Center(
          child: Text(
            'PLASMA DONORS',
            style: TextStyle(
              color: Colors.green[400],
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
            
            // Row(
            //   children: [
            //     TextButton(
            //       onPressed: () {
            //         Navigator.of(context).pushNamed(DonateForm.routeName);
            //       },
            //       child: Text('Donate'),
            //     ),
            //   ],
            // ),
            
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(20.0),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1.5 / 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 25.0,
                ),
                itemCount: donors.length,
                itemBuilder: (ctx, i) => DonorCard(
                  userName: donors[i].userName,
                  userPhone: donors[i].userPhone,
                  userLocation: donors[i].userLocation,
                  userBlood: donors[i].userBlood,
                ),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
