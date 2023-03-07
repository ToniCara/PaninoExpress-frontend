import 'dart:convert';
import 'package:paninoexpress/pages/CarrelloPage.dart';
import 'package:paninoexpress/pages/LastStepOrderPage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'FirstStepOrderPage.dart';

class SecondStepOrderPage extends StatefulWidget {
  Panino panino;

  SecondStepOrderPage({super.key, required this.panino});
  @override
  _SecondStepOrderPageState createState() => _SecondStepOrderPageState();
}

class _SecondStepOrderPageState extends State<SecondStepOrderPage> {
  List<Map<String, dynamic>> _SecondStepOrder = [];
  late Panino paninoCorrente; // dichiarazione della variabile paninoCorrente

  @override
  void initState() {
    super.initState();
    paninoCorrente = widget
        .panino; // assegnazione del panino ricevuto alla variabile paninoCorrente
    _caricaSecondStepOrder();
  }

  String _currentImage = "";

  void _onImageTapped(String imgTap) {
    setState(() {
      _currentImage = imgTap;
    });
  }

  Future<void> _caricaSecondStepOrder() async {
    final String json =
        await rootBundle.loadString('localDatas/SecondIngredients.json');
    List<dynamic> listaJson = jsonDecode(json);
    setState(() {
      _SecondStepOrder = List<Map<String, dynamic>>.from(
          listaJson.map((mappa) => Map<String, dynamic>.from(mappa)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
                  const end = Offset.zero; //Second page position
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
      body: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: _SecondStepOrder.isNotEmpty
                  ? CarouselSlider(
                      options: CarouselOptions(
                          autoPlay: false,
                          autoPlayInterval: const Duration(seconds: 3),
                          viewportFraction: 0.3,
                          height: 200,
                          enableInfiniteScroll: false,
                          scrollDirection: Axis.horizontal),
                      items: _SecondStepOrder.map((ingrediente) {
                        return Builder(
                          builder: (BuildContext context) {
                            String stringImg =
                                ingrediente['immagine'].toString();
                            return InkWell(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.network(stringImg),
                                  ],
                                ),
                              ),
                              onTap: () {
                                _onImageTapped(stringImg);
                              },
                            );
                          },
                        );
                      }).toList(),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: InkWell(
                child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    height: 400.0,
                    width: 400.0,
                    child: _currentImage != ""
                        ? Image.network(_currentImage)
                        : const Text('Non hai selezionato niente')),
                onTap: () async {
                  // Recupera la ingrediente corrente dalla lista di SecondStepOrder
                  final Map<String, dynamic> currentSecond =
                      _SecondStepOrder.firstWhere((ingrediente) =>
                          ingrediente['immagine'] == _currentImage);

                  // Aggiungi la ingrediente al carrello

                  paninoCorrente.aggiungiCondimento(
                      currentSecond['condimento'].toString());
                  paninoCorrente.aggiungiIMGCondimento(_currentImage);
                  paninoCorrente.aggiungiPrezzo(currentSecond['prezzo']);

                  // Naviga alla pagina del carrello
                  Navigator.of(context).push(PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 600),
                    reverseTransitionDuration:
                        const Duration(milliseconds: 600),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        LastStepOrderPage(panino: paninoCorrente),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0); //Initial page position
                      const end = Offset.zero; //Second page position
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
            ),
          ),
        ],
      ),
    );
  }
}
