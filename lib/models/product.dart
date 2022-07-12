import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite(String token, String userId) async {
    var oldFavorite = isFavorite;
    final url = Uri.parse(
        "https://online-magazin-e3ce2-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token");

    isFavorite = !isFavorite;
    notifyListeners();

    try {
      final response = await http.put(
        url,
        body: jsonEncode(
           isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        isFavorite = oldFavorite;
        notifyListeners();
      }
    } catch (error) {
      isFavorite = oldFavorite;
        notifyListeners();
    }
  }
}
