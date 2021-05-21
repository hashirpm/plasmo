import 'package:flutter/material.dart';
import 'package:plasmo/models/donor_model.dart';
import 'package:plasmo/widgets/donor_card.dart';
import 'package:provider/provider.dart';

class DonorGrid extends StatelessWidget {
  const DonorGrid({
    Key key,
    @required this.donors,
  }) : super(key: key);

  final List<Donor> donors;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(20.0),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1.5 / 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 25.0,
        ),
        itemCount: donors.length,
        itemBuilder: (ctx, i) =>  DonorCard(
          userName: donors[i].userName,
          userPhone: donors[i].userPhone,
          userLocation: donors[i].userLocation,
          userBlood: donors[i].userBlood,
        ),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
      );
  }
}
