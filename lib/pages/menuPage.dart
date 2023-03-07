import 'dart:convert';
import 'dart:io';
import 'package:paninoexpress/main.dart';
import 'package:paninoexpress/pages/BevandePage.dart';
import 'package:paninoexpress/pages/FirstStepOrderPage.dart';
import 'package:paninoexpress/pages/SnacksPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

import 'CarrelloPage.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MyWidgetState();
}

void _svuotaPaninoJson() async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/Panino.json');
  if (!await file.exists()) {
    await file.create(recursive: true);
  }
  List<dynamic> listaJson = await leggiJson();
  Map<String, dynamic> nuovaMappa = {};
  listaJson.add(nuovaMappa);
  String jsonString = jsonEncode(listaJson);
  await file.writeAsString(jsonString);
}

Future<List<dynamic>> leggiJson() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/Panino.json');
    if (await file.exists()) {
      String jsonContent = await file.readAsString();
      return jsonDecode(jsonContent);
    }
    return [];
  } catch (e) {
    return [];
  }
}

class _MyWidgetState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.orangeAccent[400],
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 600),
                reverseTransitionDuration: const Duration(milliseconds: 600),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const PaninoExpress(),
              ));
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
              size: 35,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
                size: 35,
              ),
              onPressed: () {
                Navigator.of(context).push(PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 600),
                  reverseTransitionDuration: const Duration(milliseconds: 600),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      CarrelloPage(),
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
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    InkWell(
                        child: Container(
                          height: 80.0,
                          width: 200.0,
                          decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 82, 73, 73),
                                  blurRadius: 10.0,
                                  spreadRadius: 3.0,
                                  offset: Offset(0.0, 10.0),
                                ),
                              ]),
                          child: const Center(
                            child: Text(
                              'BEVANDE',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 600),
                            reverseTransitionDuration:
                                const Duration(milliseconds: 600),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    BevandePage(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin =
                                  Offset(1.0, 0.0); //Initial page position
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
                        }),
                    Positioned(
                      left: 50,
                      bottom: 60,
                      child: Container(
                        height: 100,
                        width: 100,
                        // color: Colors.white,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/bevanda.png'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    InkWell(
                        child: Container(
                          height: 80.0,
                          width: 200.0,
                          padding: const EdgeInsets.all(18),
                          decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 82, 73, 73),
                                  blurRadius: 10.0,
                                  spreadRadius: 3.0,
                                  offset: Offset(10.0, 10.0),
                                ),
                              ]),
                          child: const Center(
                            child: Text(
                              'PANINI',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            ),
                          ),
                        ),
                        onTap: () {
                          _svuotaPaninoJson();
                          Navigator.of(context).push(PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 600),
                            reverseTransitionDuration:
                                const Duration(milliseconds: 600),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    FirstStepOrderPage(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin =
                                  Offset(1.0, 0.0); //Initial page position
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
                        }),
                    Positioned(
                      left: 50,
                      bottom: 60,
                      child: Container(
                        height: 100,
                        width: 100,
                        // color: Colors.white,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/panino.png"),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    InkWell(
                        child: Container(
                          height: 80.0,
                          width: 200.0,
                          decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 82, 73, 73),
                                  blurRadius: 10.0,
                                  spreadRadius: 3.0,
                                  offset: Offset(0.0, 10.0),
                                ),
                              ]),
                          child: const Center(
                            child: Text(
                              'SNACK',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 600),
                            reverseTransitionDuration:
                                const Duration(milliseconds: 600),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    SnacksPage(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin =
                                  Offset(1.0, 0.0); //Initial page position
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
                        }),
                    Positioned(
                      left: 50,
                      bottom: 60,
                      child: Container(
                        height: 100,
                        width: 100,
                        // color: Colors.white,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/snacks.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    InkWell(
                        child: Container(
                          height: 75.0,
                          width: 300.0,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 82, 73, 73),
                                  blurRadius: 10.0,
                                  spreadRadius: 3.0,
                                  offset: Offset(0.0, 10.0),
                                ),
                              ]),
                          child: const Center(
                            child: Text(
                              'Offerta del giorno',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 600),
                            reverseTransitionDuration:
                                const Duration(milliseconds: 600),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    SnacksPage(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin =
                                  Offset(1.0, 0.0); //Initial page position
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
                        }),
                    Positioned(
                      left: 50,
                      bottom: 60,
                      child: Container(
                        height: 100,
                        width: 100,
                        // color: Colors.white,
                        decoration: const BoxDecoration(),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
