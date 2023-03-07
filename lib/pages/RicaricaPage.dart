import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RicaricaPage extends StatefulWidget {
  @override
  _RicaricaPageState createState() => _RicaricaPageState();
}

class _RicaricaPageState extends State<RicaricaPage> {
  final TextEditingController _usernameController = TextEditingController();
  int _selectedAmount = 0;

  static const List<int> _amounts = [2, 5, 10, 15, 20];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("localDatas/User.json");
    List<dynamic> jsonList = json.decode(data);
    setState(() {
      //_users = jsonList.map((e) => User.fromJson(e)).toList();
      //_usernameController.text = _users[0].username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ricarica'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Seleziona l\'importo:'),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (final amount in _amounts)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedAmount = amount;
                      });
                    },
                    child: Text('$amount €'),
                    style: ElevatedButton.styleFrom(
                      primary: _selectedAmount == amount ? Colors.green : null,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String username = _usernameController.text.trim();
                if (username.isNotEmpty && _selectedAmount > 0) {
                  String data = '$username,$_selectedAmount';
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Codice QR'),
                        content: SizedBox(
                          height: 300,
                          width: 300,
                          child: Center(
                            child: RepaintBoundary(
                              child: QrImage(
                                data: data,
                                version: QrVersions.auto,
                                size: 200.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
              child: Text('Genera codice QR'),
            ),
          ],
        ),
      ),
    );
  }
}
