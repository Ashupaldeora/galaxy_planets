import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controller/planet_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> planetAnimation;
  late Animation<double> fadeAnimation;
  late Animation<double> planetReverseAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Provider.of<PlanetProvider>(context, listen: false).nextPlanet();
          animationController.reset();
        }
      });

    // rotationAnimation = Tween<double>(begin: 0, end: 0.6).animate(
    //   CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    // );
    planetReverseAnimation =
        Tween<double>(begin: 0.1, end: 0.5).animate(animationController);
    planetAnimation =
        CurvedAnimation(parent: planetReverseAnimation, curve: Curves.easeOut);

    fadeAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlanetProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(color: Color(0xff050a23)),
          Positioned(
            top: 70,
            left: 20,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 700),
              opacity: provider.isPlanetOpened ? 0 : 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome",
                      style: GoogleFonts.exo(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600))),
                  Text("Ashu",
                      style: GoogleFonts.exo(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500))),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            top: provider.isPlanetOpened ? 180 : 300,
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              height: provider.isPlanetOpened ? 200 : 400,
              width: MediaQuery.of(context).size.width * 0.99,
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                  color: Color(0xff1d3c7d),
                  spreadRadius: 0,
                  blurRadius: 130,
                  offset: Offset(0, 3),
                ),
                BoxShadow(
                  color: Color(0xff1d3c7d),
                  spreadRadius: 0,
                  blurRadius: 130,
                  offset: Offset(0, 3),
                ),
              ]),
            ),
          ),
          AnimatedPositioned(
              duration: Duration(seconds: 1),
              top: provider.isPlanetOpened ? 60 : 300,
              width: 410,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      FadeTransition(
                        opacity: fadeAnimation,
                        child: Text(
                          provider.currentPlanet.planetName!,
                          style: GoogleFonts.exo(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                      SizedBox(height: 5),
                      FadeTransition(
                        opacity: fadeAnimation,
                        child: Text(
                          provider.currentPlanet.subtitle!,
                          style: GoogleFonts.exo(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            bottom: (provider.currentPlanetIndex == 0 ||
                    provider.currentPlanetIndex == 2)
                ? provider.isPlanetOpened
                    ? 440
                    : -80
                : (provider.currentPlanetIndex == 3 ||
                        provider.currentPlanetIndex == 7)
                    ? provider.isPlanetOpened
                        ? 450
                        : -150
                    : provider.currentPlanetIndex == 4
                        ? provider.isPlanetOpened
                            ? 450
                            : -140
                        : provider.currentPlanetIndex == 5
                            ? provider.isPlanetOpened
                                ? 480
                                : -220
                            : provider.currentPlanetIndex == 8
                                ? provider.isPlanetOpened
                                    ? 460
                                    : -160
                                : provider.currentPlanetIndex == 9
                                    ? provider.isPlanetOpened
                                        ? 430
                                        : -200
                                    : provider.isPlanetOpened
                                        ? 460
                                        : -120,
            right: (provider.currentPlanetIndex == 3)
                ? provider.isPlanetOpened
                    ? 50
                    : -120
                : provider.currentPlanetIndex == 4
                    ? provider.isPlanetOpened
                        ? 50
                        : -130
                    : provider.currentPlanetIndex == 5
                        ? provider.isPlanetOpened
                            ? 50
                            : -170
                        : provider.currentPlanetIndex == 6
                            ? provider.isPlanetOpened
                                ? 50
                                : -100
                            : provider.currentPlanetIndex == 7
                                ? provider.isPlanetOpened
                                    ? 50
                                    : -120
                                : provider.currentPlanetIndex == 8
                                    ? provider.isPlanetOpened
                                        ? 50
                                        : -120
                                    : provider.currentPlanetIndex == 9
                                        ? provider.isPlanetOpened
                                            ? 50
                                            : -370
                                        : provider.isPlanetOpened
                                            ? 50
                                            : -80,
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! < 0 && !provider.isPlanetOpened) {
                  animationController.forward();
                }
              },
              onTap: () {
                provider.updatePlanetOpened(true);
                provider.startTextAnimation();
              },
              onVerticalDragUpdate: (details) {
                if (details.primaryDelta! > 0) {
                  provider.updatePlanetOpened(false);
                  provider.removeTextAnimation();
                }
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 1500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                      opacity: fadeAnimation,
                      child: RotationTransition(
                          turns: planetAnimation.drive(
                            Tween<double>(begin: 0.1, end: -0.5),
                          ),
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.15, 0.1),
                              end: const Offset(0 - 0.7, -0.6),
                            ).animate(planetAnimation),
                            child: child,
                          )));
                },
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  height: (provider.currentPlanetIndex == 0 ||
                          provider.currentPlanetIndex == 2)
                      ? provider.isPlanetOpened
                          ? 300
                          : 570
                      : provider.currentPlanetIndex == 1
                          ? provider.isPlanetOpened
                              ? 300
                              : 630
                          : provider.currentPlanetIndex == 5
                              ? provider.isPlanetOpened
                                  ? 300
                                  : 780
                              : provider.isPlanetOpened
                                  ? 300
                                  : 650,
                  child: Image.asset(
                    provider.planetData[provider.currentPlanetIndex].image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          provider.showText
              ? AnimatedPositioned(
                  left: 125,
                  top: 500,
                  right: provider.textAnimation ? 130 : -150,
                  child: Text(provider.currentPlanet.distance!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.exo(
                          textStyle: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 25,
                              fontWeight: FontWeight.w500))),
                  duration: Duration(seconds: 1))
              : SizedBox()
        ],
      ),
    );
  }
}
