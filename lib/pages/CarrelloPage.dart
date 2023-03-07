import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class CarrelloPage extends StatefulWidget {
  @override
  _CarrelloPageState createState() => _CarrelloPageState();
}

double totPrezzoCarrello = 0;

class _CarrelloPageState extends State<CarrelloPage> {
  List<dynamic> _listaJson = [];

  @override
  void initState() {
    super.initState();
    _leggiJson();
    _calcolaTotale();
  }

  Future<void> _leggiJson() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/CartShop.json');
    if (await file.exists()) {
      String jsonString = await file.readAsString();
      setState(() {
        _listaJson = jsonDecode(jsonString);
      });
    }
  }

  Future<void> _salvaJson() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/CartShop.json');
    await file.writeAsString(jsonEncode(_listaJson));
  }

  Future<void> _salvaOrdineJson() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/Ordini.json');
    await file.writeAsString(jsonEncode(_listaJson));
  }

  void _rimuoviElemento(int index) {
    setState(() {
      _listaJson.removeAt(index);
      _salvaJson();
      _calcolaTotale();
    });
  }

  void _confermaOrdine() async {
    _salvaOrdineJson();
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/CartShop.json');
    await file.delete();
    setState(() {
      _listaJson = [];
      _calcolaTotale();
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Ordine confermato"),
          content: const  Text("Grazie per il tuo ordine!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _calcolaTotale() {
  totPrezzoCarrello = 0;
  _listaJson.forEach((item) {
    totPrezzoCarrello += item["totPrezzo"];
  });
  }

  Widget _buildItem(dynamic item) {
  _calcolaTotale();
  if (item["categoria"] == "Panino") {
    return Card(
      child: ListTile(
        title: Text(item["nome"]),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Totale prezzo: ${item["totPrezzo"]}€"),
            const SizedBox(height: 8),
            Row(
              children: [
                Image.network(
                  item["immagine-pane"].toString(),
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 8),
                Image.network(
                  item["immagine-condimento"].toString(),
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 8),
                Image.network(
                  item["immagine-add"].toString(),
                  width: 50,
                  height: 50,
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            _rimuoviElemento(_listaJson.indexOf(item));
          },
        ),
      ),
    );
  } else {
    return Card(
      child: ListTile(
        title: Text(item["nome"]),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Totale prezzo: ${item["totPrezzo"]}€"),
            const SizedBox(height: 8),
            Row(
              children: [
                Image.network(
                  item["immagini"].toString(),
                  width: 50,
                  height: 50,
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            _rimuoviElemento(_listaJson.indexOf(item));
          },
        ),
      ),
    );
  }
}



  @override
  Widget build(BuildContext context) {
  _calcolaTotale();
  return Scaffold(
    appBar: AppBar(
      title: const Text("Carrello"),
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          color: Theme.of(context).primaryColor,
          child: Text(
            "Totale Carrello: (${totPrezzoCarrello.toStringAsFixed(2)})",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Expanded(
          child: _listaJson.isNotEmpty
              ? ListView.builder(
                  itemCount: _listaJson.length,
                  itemBuilder: (BuildContext context, int index) {
                    _calcolaTotale();
                    return _buildItem(_listaJson[index]);
                  },
                )
              : const Center(
                  child: Text("Il carrello è vuoto"),
                ),
        ),
      ],
    ),
    bottomNavigationBar: _listaJson.isNotEmpty
        ? BottomAppBar(
            child: ElevatedButton(
              onPressed: () {
                _confermaOrdine();
              },
              child: const Text("Conferma ordine"),
            ),
          )
        : null,
  );
}


}