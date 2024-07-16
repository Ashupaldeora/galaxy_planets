import 'package:flutter/material.dart';
import 'package:galaxy_planets/controller/planet_provider.dart';
import 'package:provider/provider.dart';

import 'custom_card.dart';

class ShowPlanetDetails extends StatefulWidget {
  const ShowPlanetDetails({super.key});

  @override
  State<ShowPlanetDetails> createState() => _ShowPlanetDetailsState();
}

class _ShowPlanetDetailsState extends State<ShowPlanetDetails> {
  List<CustomCard> listOfWidgets = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final Tween<Offset> _offset =
      Tween(begin: const Offset(1, 0), end: const Offset(0, 0));

  Color bgColor = Colors.transparent;

  Future<void> _addData() async {
    List listOfData = [
      CustomCard(
        leading: Image.asset("assets/images/orbit.png", color: Colors.white),
        title: 'orbital_period',
        subtitle: Provider.of<PlanetProvider>(context, listen: false)
            .currentPlanet
            .orbitalPeriod
            .toString(),
      ),
      CustomCard(
        leading: Image.asset("assets/images/gravity.png", color: Colors.white),
        title: 'Gravity',
        subtitle: Provider.of<PlanetProvider>(context, listen: false)
            .currentPlanet
            .gravity
            .toString(),
      ),
      CustomCard(
        leading:
            Image.asset("assets/images/day-and-night.png", color: Colors.white),
        title: "Length of day",
        subtitle: Provider.of<PlanetProvider>(context, listen: false)
            .currentPlanet
            .lengthOfDay
            .toString(),
      ),
      CustomCard(
        leading: Image.asset("assets/images/map.png", color: Colors.white),
        title: "Surface Area",
        subtitle: Provider.of<PlanetProvider>(context, listen: false)
            .currentPlanet
            .surfaceArea
            .toString(),
      ),
    ];

    for (var data in listOfData) {
      await Future.delayed(const Duration(milliseconds: 500));
      listOfWidgets.add(data);
      _listKey.currentState?.insertItem(listOfWidgets.length - 1);
    }

    setState(() {
      bgColor = Color(0xff050a23);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _addData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 1,
        duration: const Duration(seconds: 1),
        color: bgColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: AnimatedList(
              shrinkWrap: true,
              key: _listKey,
              initialItemCount: listOfWidgets.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index, animation) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: SlideTransition(
                    position: animation.drive(_offset),
                    child: listOfWidgets[index],
                  ),
                );
              }),
        ));
  }
}
