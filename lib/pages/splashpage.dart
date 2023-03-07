import 'package:flutter/material.dart';
import 'dart:async';

import 'package:paninoexpress/pages/menuPage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  DateTime now = DateTime.now();
  late Timer _timer =
      Timer.periodic(Duration.zero, (_) {}); // initialize with a dummy value
  int _secondsLeft = 0;

  @override
  void initState() {
    super.initState();
    _setTimer();
  }

  @override
  void dispose() {
    if (_timer != Timer.periodic(Duration.zero, (_) {})) {
      // check if _timer has been initialized
      _timer.cancel();
    }
    super.dispose();
  }

  void _setTimer() {
    final now = DateTime.now();
    final elevenAM = DateTime(now.year, now.month, now.day, 11, 0, 0);
    final diff = elevenAM.difference(now);
    _secondsLeft = diff.inSeconds;
    if (_secondsLeft > 0) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() {
          if (_secondsLeft > 0) {
            _secondsLeft--;
          } else {
            _timer.cancel();
          }
        });
      });
    } else {
      _secondsLeft = 0;
    }
  }

  String _formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final remainingSeconds = seconds % 3600;
    final minutes = remainingSeconds ~/ 60;
    final formattedHours = hours.toString().padLeft(2, '0');
    final formattedMinutes = minutes.toString().padLeft(2, '0');
    final formattedSeconds = (remainingSeconds % 60).toString().padLeft(2, '0');
    return '$formattedHours:$formattedMinutes:$formattedSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bkgHome.jpg"),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 240),
            Text(
              _formatTime(_secondsLeft),
              style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 300),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                    height: 60.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(
                          color: const Color.fromARGB(255, 74, 72, 72)),
                    ),
                    child: const Center(
                      child: Text(
                        'MENU',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 600),
                      reverseTransitionDuration:
                          const Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const MenuPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0); //Initial page position
                        const end = Offset.zero; //last page position
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ));
                  },
                ),
                const SizedBox(width: 50),
                InkWell(
                  child: Container(
                    height: 60.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(
                          color: const Color.fromARGB(255, 74, 72, 72)),
                    ),
                    child: const Center(
                      child: Text(
                        'ORDINA',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 600),
                      reverseTransitionDuration:
                          const Duration(milliseconds: 600),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const MenuPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0); //Initial page position
                        const end = Offset.zero; //last page position
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ));
                  },
                ),
              ],
            ),
          ])),
    );
  }
}
