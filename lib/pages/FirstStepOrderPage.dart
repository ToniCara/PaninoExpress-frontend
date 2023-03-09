import 'dart:convert';
import 'package:paninoexpress/models.dart';
import 'package:paninoexpress/pages/SecondStepOrderPage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
class Panino {
  String pane = "";
  String IMGpane = "";
  String condimento = "";
  String IMGcondimento = "";
  String add = "";
  String IMGadd = "";
  double prezzo = 0;

  // funzione per aggiungere un condimento
  void aggiungiCondimento(String condimentoFun) {
    condimento = condimentoFun;
  }

  String getPane(){
    return pane;
  }
  String getIMGpane(){
    return IMGpane;
  }
  String getCondimento(){
    return condimento;
  }
  String getIMGcondimento(){
    return IMGcondimento;
  }
  String getAdd(){
    return add;
  }
  String getIMGadd(){
    return IMGadd;
  }
  double getPrezzo(){
    return prezzo;
  }


  // funzione per rimuovere un condimento
  void rimuoviCondimento() {
    condimento = "";
  }

  // funzione per aggiungere un adds
  void aggiungiAdd(String AddFun) {
    add = AddFun;
  }

  // funzione per rimuovere una Adds
  void rimuoviAdds() {
    add = "";
  }

  // funzione per aggiungere un condimento
  void aggiungiIMGCondimento(String IMGcondimentoFun) {
    IMGcondimento = IMGcondimentoFun;
  }

  // funzione per rimuovere un condimento
  void rimuoviIMGCondimento() {
    IMGcondimento = "";
  }

  // funzione per aggiungere un adds
  void aggiungiIMGAdd(String IMGAddFun) {
    IMGadd = IMGAddFun;
  }

  // funzione per rimuovere una Adds
  void rimuoviIMGAdds() {
    IMGadd = "";
  }

  void aggiungiPrezzo(double prezzoFun) {
    prezzo += prezzoFun;
  }

  void aggiungiPane(String paneFun) {
    pane = paneFun;
  }

  void rimuoviPane() {
    pane = "";
  }

  void aggiungiIMGPane(String IMGpaneFun) {
    IMGpane = IMGpaneFun;
  }

  void rimuoviIMGPane() {
    IMGpane = "";
  }

  void rimuoviPrezzo(double prezzoFun) {
    prezzo -= prezzoFun;
  }
}


class FirstStepOrderPage extends StatefulWidget {
  @override
  _FirstStepOrderPageState createState() => _FirstStepOrderPageState();
}


class _FirstStepOrderPageState extends State<FirstStepOrderPage> {
  List<Map<String, dynamic>> _FirstStepOrder = [];
  final panino = Panino();
  //List<Ingredient> ingredients = [];

  void retrieveIngredients() async{
    final response = await http.get(Uri.parse('http://justitis.com:8000/ingredient'));
    if(response.statusCode == 200){
      Ingredients ingredients = Ingredients.fromJson(jsonDecode(response.body));
      print(ingredients);
    }
  }

  @override
  void initState() {
    super.initState();
    //_caricaFirstStepOrder();
    retrieveIngredients();
  }

  String _currentImage = "";

  void _onImageTapped(String imgTap) {
    setState(() {
      _currentImage = imgTap;
    });
  }

  Future<void> _caricaFirstStepOrder() async {
    final String json =
        await rootBundle.loadString('localDatas/FirstIngredients.json');
    List<dynamic> listaJson = jsonDecode(json);
    setState(() {
      _FirstStepOrder = List<Map<String, dynamic>>.from(
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

              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SecondStepOrderPage(panino: panino),
              ),
              );
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
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100)),
              child: _FirstStepOrder.isNotEmpty
                  ? CarouselSlider(
                      options: CarouselOptions(
                          autoPlay: false,
                          autoPlayInterval: const Duration(seconds: 3),
                          viewportFraction: 0.3,
                          height: 200,
                          enableInfiniteScroll: false,
                          scrollDirection: Axis.horizontal),
                      items: _FirstStepOrder.map((ingrediente) {
                        return Builder(
                          builder: (BuildContext context) {
                            String stringImg = ingrediente['immagine'].toString();
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100)
          ),
        
        child: InkWell(
                      child: Container(

                      color: Colors.transparent,
                      alignment: Alignment.center,
                      height: 400.0,
                      width: 400.0,
                      
                      child:  _currentImage != ""
                              ? Image.network(_currentImage)
                              : const Text('Non hai selezionato niente')
                       
                      
                        
                        
                      ),
                      onTap: () async {
                        // Recupera la ingrediente corrente dalla lista di FirstStepOrder
                        final Map<String, dynamic> currentFirstStepOrder = _FirstStepOrder.firstWhere((ingrediente) => ingrediente['immagine'] == _currentImage);
                        
                        // Aggiungi la ingrediente al panino                        
                        panino.aggiungiPane(currentFirstStepOrder['id'].toString());
                        panino.aggiungiIMGPane(_currentImage);
                        panino.aggiungiPrezzo(currentFirstStepOrder['prezzo']);
                        
                        // Naviga alla pagina del carrello
                        Navigator.of(context)
                            .push( PageRouteBuilder(
                              transitionDuration: const Duration(milliseconds: 600),
                              reverseTransitionDuration: const Duration(milliseconds: 600),
                              pageBuilder: (context, animation, secondaryAnimation) => SecondStepOrderPage(panino: panino),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0); //Initial page position
                                const end = Offset.zero; //First page position
                                const curve = Curves.easeInOut;
                                var tween = Tween(begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                
                                return SlideTransition(position: animation.drive(tween),child: child,
                                );
                      },



                            )

                            );
                        },
                    ),
              ),
      ), 
    ], ),
    );
  }
}