import 'dart:convert';

import 'models.dart';
import 'package:http/http.dart' as http;

void main(List<String> args) async{

  const List<DetailedOrder> detord = [
    DetailedOrder(idOrderDetail: 7, idIngredient: 1, collectionType: -1),
    DetailedOrder(idOrderDetail: 7, idIngredient: 3, collectionType: -1),
    DetailedOrder(idOrderDetail: 5, idIngredient: 1, collectionType: -1),
    DetailedOrder(idOrderDetail: 6, idIngredient: 3, collectionType: -1),
  ];



  var client = http.Client();
  Map<String, String> headers = {
    'token': "ya29.a0AVvZVspW9hcOysHpPjWCUBgvx_9ENsypBRV2rLYJJVympm22Mi4dGTuBfOzmpSdGCG9qQGgwhRrqEsEOCPzHz1zdpKBeeBfyNTJOSs2IB0O5WI-_2g7NYl8uev7Kmvct463qTkSkSTxRxGpmA--1b39GhoFG3QaCgYKAbgSARISFQGbdwaIlCtg04wudtDn_EYD5XCvgQ0165",
    'data': jsonEncode(detord)
  };
  try{
    var response = await client.get(Uri.parse('http://justitis.com:8000/orders/do'), headers: headers);
    var decResp = response.body;
    print(decResp);
  }finally{

  }
  
}