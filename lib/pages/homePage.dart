import 'package:flutter/material.dart';
import 'aboutuspage.dart';
import 'splashpage.dart';


class HomePage extends StatelessWidget {
// const HomePage({ Key? key }) : super(key: key);
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.vertical,
        children: [
          SplashPage(),
          Aboutus(),
        ],
      ),
    );
  }
}