import 'dart:convert';
import 'dart:io';
import 'package:paninoexpress/pages/menuPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'FirstStepOrderPage.dart';

class LastStepOrderPage extends StatefulWidget {
  Panino panino;

  LastStepOrderPage({required this.panino});
  @override
  _LastStepOrderPageState createState() => _LastStepOrderPageState();
}

class _LastStepOrderPageState extends State<LastStepOrderPage> {
  List<Map<String, dynamic>> _LastStepOrder = [];
  late Panino paninoCorrente; // dichiarazione della variabile paninoCorrente

  @override
  void initState() {
    super.initState();
    paninoCorrente = widget
        .panino; // assegnazione del panino ricevuto alla variabile paninoCorrente
    _caricaLastStepOrder();
  }

  String _currentImage = "";

  void _onImageTapped(String imgTap) {
    setState(() {
      _currentImage = imgTap;
    });
  }

  Future<void> _caricaLastStepOrder() async {
    final String json =
        await rootBundle.loadString('localDatas/LastIngredients.json');
    List<dynamic> listaJson = jsonDecode(json);
    setState(() {
      _LastStepOrder = List<Map<String, dynamic>>.from(
          listaJson.map((mappa) => Map<String, dynamic>.from(mappa)));
    });
  }

  void scriviInJson(Panino panino) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/CartShop.json');
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    List<dynamic> listaJson = await leggiJson();
    Map<String, dynamic> nuovaMappa = {
      "nome": "Panino",
      "categoria": "Panino",
      "id-pane": panino.getPane(),
      "id-condimento": panino.getCondimento(),
      "id-add": panino.getAdd(),
      "immagine-pane": panino.getIMGpane(),
      "immagine-condimento": panino.getIMGcondimento(),
      "immagine-add": panino.getIMGadd(),
      "totPrezzo": panino.getPrezzo(),
    };
    listaJson.add(nuovaMappa);
    String jsonString = jsonEncode(listaJson);
    await file.writeAsString(jsonString);
  }

  Future<List<dynamic>> leggiJson() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/CartShop.json');
      if (await file.exists()) {
        String jsonContent = await file.readAsString();
        return jsonDecode(jsonContent);
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: 35,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
              size: 35,
            ),
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 600),
                reverseTransitionDuration: const Duration(milliseconds: 600),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    MenuPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0); //Initial page position
                  const end = Offset.zero; //second page position
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
              child: _LastStepOrder.isNotEmpty
                  ? CarouselSlider(
                      options: CarouselOptions(
                          autoPlay: false,
                          autoPlayInterval: Duration(seconds: 3),
                          viewportFraction: 0.3,
                          height: 200,
                          enableInfiniteScroll: false,
                          scrollDirection: Axis.horizontal),
                      items: _LastStepOrder.map((ingrediente) {
                        return Builder(
                          builder: (BuildContext context) {
                            String stringImg =
                                ingrediente['immagine'].toString();
                            return InkWell(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
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
                  : Center(
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
                        : Text('Non hai selezionato niente')),
                onTap: () async {
                  // Recupera la ingrediente corrente dalla lista di LastStepOrder
                  final Map<String, dynamic> currentIngredient =
                      _LastStepOrder.firstWhere((ingrediente) =>
                          ingrediente['immagine'] == _currentImage);

                  // Aggiungi la ingrediente al carrello

                  paninoCorrente
                      .aggiungiAdd(currentIngredient['condimento'].toString());
                  paninoCorrente.aggiungiIMGAdd(_currentImage);
                  paninoCorrente.aggiungiPrezzo(currentIngredient['prezzo']);

                  scriviInJson(paninoCorrente);
                  // Naviga alla pagina del carrello
                  Navigator.of(context).push(PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 600),
                    reverseTransitionDuration:
                        const Duration(milliseconds: 600),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        MenuPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0); //Initial page position
                      const end = Offset.zero; //second page position
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
