import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class OrdinePage extends StatefulWidget {
  @override
  _OrdinePageState createState() => _OrdinePageState();
}

double totPrezzoOrdine = 0;

class _OrdinePageState extends State<OrdinePage> {
  List<dynamic> _listaJson = [];

  @override
  void initState() {
    super.initState();
    _leggiJson();
    _calcolaTotale();
  }

  Future<void> _leggiJson() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/Ordini.json');
    if (await file.exists()) {
      String jsonString = await file.readAsString();
      setState(() {
        _listaJson = jsonDecode(jsonString);
      });
    }
  }


  void _calcolaTotale() {
  totPrezzoOrdine = 0;
  _listaJson.forEach((item) {
    totPrezzoOrdine += item["totPrezzo"];
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
      title: const Text("Ultimo ordine effettuato"),
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          color: Theme.of(context).primaryColor,
          child: Text(
            "Totale Ordine: (${totPrezzoOrdine.toStringAsFixed(2)})",
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
                  child: Text("Non hai effettuato ordini"),
                ),
        ),
      ],
    ),
  );
}


}