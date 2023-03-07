import 'dart:convert';

class User{
  final int userId; //id_utente
  final String firstName; //nome
  final String lastName; //cognome
  final String email; // email
  final double balance; //bilancio

  const User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.balance,
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      balance: json['balance'],
    );
  }
}

class Ingredient{
  final int ingredientId; //id_ingrediente
  final String name; //nome
  final String description; //descrizione
  final int productType; //tipo prodotto
  final double price; //prezzo

  const Ingredient({
    required this.ingredientId,
    required this.name,
    required this.description,
    required this.productType,
    required this.price,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json){
    return Ingredient(
      ingredientId: json['ingredientId'],
      name: json['name'],
      description: json['description'],
      productType: json['productType'],
      price: json['price'],
    );
  }
}

class Ingredients{
  final List<Ingredient> ingredients;

  const Ingredients({required this.ingredients});

  factory Ingredients.fromJson(Map<String, dynamic> json){
    return Ingredients(ingredients: json['ingredients']);
  }
}

class DetailedOrder{
  final int idOrderDetail;
  final int idIngredient;
  final int collectionType;

  const DetailedOrder({
    required this.idOrderDetail,
    required this.idIngredient,
    required this.collectionType
  });

  Map<String, dynamic> toJson() => {
    'idOrderDetail': idOrderDetail,
    'idIngredient': idIngredient,
    'collectionType': collectionType
  };
}

class DetailedOrders{
  final List<DetailedOrder> detailedOrders;

  const DetailedOrders({
    required this.detailedOrders
  });

  Map<String, dynamic> toJson() => {
    '': jsonEncode(detailedOrders)
  };
}

class CompletedOrder{
  final int idOrderDetail;
  final List<DetailedOrder> detailedOrders;

  const CompletedOrder({
    required this.idOrderDetail,
    required this.detailedOrders
  });
}